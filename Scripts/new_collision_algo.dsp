import("stdfaust.lib");
import("mi.lib");

// collision
// k,z: stiffness and daming (algorithmic values)
// thres: position threshold for the collision to be active
new_collision(k,z,thres,x1r0,x2r0,x1,x2) = spring(k,z,x1r0,x2r0,x1,x2) : (select2(comp,0,_),select2(comp,0,_))
with{
  comp = (x2-x1)<thres;
};


in1 =  hslider("position",0,-1,1,0.0001) : si.smoo ;

OutGain = 50;

nlK = 0.1;
nlscale = 0.0005;

model = (RoutingLinkToMass, _: 
			ground(0.),
			mass(1.0,0., 0.0),
			mass(1.0,0., 0.),
			posInput(0.) :
		RoutingMassToLink : 
			spring(0.1,0.01, 0., 0.),
			spring(0.1,0.01, 0., 0.),
		 	//nlPluck(nlK,nlscale),
			new_collision(0.1,0.01,0., 0, 0.),
		par(i, 1,_)
		)~par(i, 6, _):par(i, 6,!), par(i,  1, _)
with{
RoutingLinkToMass(l0_f1,l0_f2,l1_f1,l1_f2,l2_f1,l2_f2) = l0_f1, l0_f2+l1_f1+l2_f2, l1_f2, l2_f1;
RoutingMassToLink(m0,m1,m2,m3) = m0, m1, m1, m2, m3, m1,m1;
};
process = in1 : si.smoo : model: *(OutGain);