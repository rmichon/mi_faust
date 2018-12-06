import("stdfaust.lib");
import("mi.lib");

new_collision(k,z,thres,x1r0,x2r0,x1,x2) = spring(k,z,x1r0,x2r0,x1,x2) : 
                (select2(comp,0,_),select2(comp,0,_))
                with{
                comp = (x2-x1)<thres;
                };


in1 = hslider("position2",0,-1,1,0.0001) : si.smoo ;
in2 = hslider("position",0,-0.8,0.8,0.0001) : si.smoo ;

gateT = button("gate"):ba.impulsify;
frcIn = gateT * 0.0005;

OutGain = 50.;

nlK = 0.1;
nlscale = 0.0005;

model = (RoutingLinkToMass: 
ground(0.),
mass(1.0,0., 0.),
posInput(0.),
posInput(0.) :
RoutingMassToLink : 
spring(0.1,0.01, 0., 0.),
new_collision(0.1,0.01,0., 0, 0.),
new_collision(0.1,0.01,0., 0, 0.),         par(i, 1,_)
)~par(i, 6, _):         par(i, 6,!), par(i,  1, _)
with{
RoutingLinkToMass(l0_f1,l0_f2,l1_f1,l1_f2,l2_f1,l2_f2) = l0_f1, l0_f2+l1_f2+l2_f2+frcIn, l1_f1, in1, l2_f1, in2;
RoutingMassToLink(m0,m1,m2,m3) = m0, m1, m2, m1, m3, m1,m1;
};
process = model: *(OutGain);