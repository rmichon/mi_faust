 
import("stdfaust.lib");

Fe = ma.SR;

impulsify = _ <: _,mem : - <: >(0)*_;

// integrated oscillator (mass-spring-ground system)
// m, k, z: mass, stiffness, damping (algorithmic values)
// x0, x1: initial position and delayed position
osc(m,k,z,x0,x1) = equation
with{
  A = 2-(k+z)/m;
  B = z/m-1;
  C = 1/m;
  equation = x 
	letrec{
  		'x = A*(x + (x0 : impulsify)) + B*(x' + (x1 : impulsify)) + C*_;
	};
};

// punctual mass module
// m: mass (algorithmic value)
// x0, x1: initial position and delayed position
mass(m,x0,x1) = equation
with{
  A = 2;
  B = -1;
  C = 1/m;
  equation = x 
	letrec{
  		'x = A*(x + (x0 : impulsify)) + B*(x' + (x1 : impulsify) + (x0 : impulsify)') + C*_;
	};
};

// punctual ground module
// x0: initial position
ground(x0) = equation
with{
  // could this term be removed or simlified? Need "unused" input force signal for routing scheme
  C = 0;
  equation = x 
	letrec{
		'x = x + (x0 : impulsify) + C*_;
	};
};

// spring
// k,z: stiffness and daming (algorithmic values)
spring(k,z,x1,x2) = k*(x2-x1) + z*((x2-x2')-(x1-x1')) <: _,_*(-1);

// nlPluck
// 1D non-linear picking Interaction algorithm
nlPluck(k,scale,x1,x2) = 
  select2(
    absdeltapos>scale,
    select2(
      absdeltapos>scale*0.5,
      k*deltapos,
      k*(ma.signum(deltapos)*scale*0.5-deltapos)),
    0) <: _,*(-1)
with{
  deltapos = x1 - x2;
  absdeltapos = abs(deltapos);
};

// nlBow
// 1D non-linear bowing Interaction algorithm 
nlBow(z,scale,x1,x1r,x2,x2r) = 
  select2(
    absspeed < (scale/3),
    select2(
      absspeed<scale,
      0,
      select2(
        speed>0,
        (scale/3)*z + (-z/4)*speed,
        (-scale/3)*z + (-z/4)*speed
        )
      ),
    z*speed) <: _,*(-1)
with{
  speed = (x1-x1r) - (x2-x2r);
  absspeed = abs(speed);
};

// collision
// k,z: stiffness and daming (algorithmic values)
// thres: position threshold for the collision to be active
collision(k,z,thres,x1,x2) = spring(k,z,x1,x2) : (select2(comp,0,_),select2(comp,0,_))
with{
  comp = (x2-x1)<thres;
};

posInput(init) = _,_ : !,_ :+(init : impulsify); 
model = (RoutingLinkToMass, _: 
ground(0.),
ground(0.),
mass(1.0,0., 0.),
mass(1.0,0., 0.),
mass(1.0,0., 0.),
posInput(0.) :
RoutingMassToLink : 
spring(0.1,0.01),
spring(0.1,0.01),
spring(0.1,0.01),
spring(0.1,0.01),
nlPluck(0.01,0.01),         par(i, 2,_))~par(i, 10, _):         par(i, 10,!), par(i,  2, _)
with{
RoutingLinkToMass(l0_f1,l0_f2,l1_f1,l1_f2,l2_f1,l2_f2,l3_f1,l3_f2,l4_f1,l4_f2) = l0_f1, l3_f2, l0_f2+l1_f1, l1_f2+l2_f1+l4_f2, l2_f2+l3_f1, l4_f1;
RoutingMassToLink(m0,m1,m2,m3,m4,m5) = m0, m2, m2, m3, m3, m4, m4, m1, m5, m3,m4,m3;
};
process = hslider("position",1,-1,1,0.01) : si.smoo : model: *(50.), *(50.);