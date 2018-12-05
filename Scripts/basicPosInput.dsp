
model = (RoutingLinkToMass : 
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
collision(0.1,0.01,0.),         par(i, 0,_))~par(i, 10, _):         par(i, 10,!), par(i,  0, _)
with{
RoutingLinkToMass(l0_f1,l0_f2,l1_f1,l1_f2,l2_f1,l2_f2,l3_f1,l3_f2,l4_f1,l4_f2) = l0_f1, l3_f2, l0_f2+l1_f1, l1_f2+l2_f1+l4_f2, l2_f2+l3_f1, l4_f1;
RoutingMassToLink(m0,m1,m2,m3,m4,m5) = m0, m2, m2, m3, m3, m4, m4, m1, m5, m3,
};
process = model: *(0.5), *(0.5);