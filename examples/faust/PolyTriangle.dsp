import("stdfaust.lib");
import("../../faust/mi.lib");

gateT = button("gate"):ba.impulsify;
in1 = gateT * 0.1; 

OutGain = 0.5;

m_K = hslider("pitch", 0.1, 0.0001, 0.3, 0.00001) ;
m_Z = hslider("damping", 0.0001, 0.00001, 0.01, 0.00001) ;

model = (RoutingLinkToMass: 
ground(0.),
mass(1.,0., 0.),
mass(1.,0., 0.),
mass(1.,0., 0.) :
RoutingMassToLink : 
spring(0.05,0.01, 0., 0.),
spring(m_K,m_Z, 0., 0.),
spring(m_K,m_Z, 0., 0.),
spring(m_K,m_Z, 0., 0.),         par(i, 1,_)
)~par(i, 8, _):         par(i, 8,!), par(i,  1, _)
with{
RoutingLinkToMass(l0_f1,l0_f2,l1_f1,l1_f2,l2_f1,l2_f2,l3_f1,l3_f2, f_in1) = l0_f1, l0_f2+l1_f1+l3_f2, f_in1+l1_f2+l2_f1, l2_f2+l3_f1;
RoutingMassToLink(m0,m1,m2,m3) = m0, m1, m1, m2, m2, m3, m3, m1,m3;
};
process = in1: model: *(OutGain);