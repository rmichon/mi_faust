import("stdfaust.lib");
import("../../faust/mi.lib");

gateT = button("gate"):ba.impulsify;
in1 = gateT * 0.1; 

OutGain = 0.1;

str_M = 1.0;
str_K = 0.000001;
str_Z = 0.0001;

model = (RoutingLinkToMass: 
ground(0.),
ground(0.),
mass(str_M,0., 0.),
mass(str_M,0., 0.),
mass(str_M,0., 0.),
mass(str_M,0., 0.),
mass(str_M,0., 0.),
mass(str_M,0., 0.),
mass(str_M,0., 0.),
mass(str_M,0., 0.),
mass(str_M,0., 0.),
mass(str_M,0., 0.) :
RoutingMassToLink : 
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),
spring(str_K,str_Z, 0., 0.),         par(i, 1,_)
)~par(i, 22, _):         par(i, 22,!), par(i,  1, _)
with{
RoutingLinkToMass(l0_f1,l0_f2,l1_f1,l1_f2,l2_f1,l2_f2,l3_f1,l3_f2,l4_f1,l4_f2,l5_f1,l5_f2,l6_f1,l6_f2,l7_f1,l7_f2,l8_f1,l8_f2,l9_f1,l9_f2,l10_f1,l10_f2, f_in1) = l0_f1, l10_f2, f_in1+l0_f2+l1_f1, l1_f2+l2_f1, l2_f2+l3_f1, l3_f2+l4_f1, l4_f2+l5_f1, l5_f2+l6_f1, l6_f2+l7_f1, l7_f2+l8_f1, l8_f2+l9_f1, l9_f2+l10_f1;
RoutingMassToLink(m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11) = m0, m2, m2, m3, m3, m4, m4, m5, m5, m6, m6, m7, m7, m8, m8, m9, m9, m10, m10, m11, m11, m1,m3;
};
process = in1 : model : *(OutGain)*no.noise ;