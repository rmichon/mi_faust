import("stdfaust.lib");
import("mi.lib");

new_collision(k,z,thres,x1r0,x2r0,x1,x2) = spring(k,z,x1r0,x2r0,x1,x2) : 
                (select2(comp,0,_),select2(comp,0,_))
                with{
                comp = (x2-x1)<thres;
                };

in1 = vslider("pos",1,-1,1,0.0001) : si.smoo;




OutGain = 50.;

m_K = 0.1;
m_Z = 0.001;
nlK = 0.05;
nlScale = 0.01;

model = (RoutingLinkToMass: 
ground(0.),
mass(1.,0., 0.),
mass(1.,0., 0.),
mass(1.,0., 0.),
posInput(0.) :
RoutingMassToLink : 
spring(0.05,0.01, 0., 0.),
spring(m_K,m_Z, 0., 0.),
spring(m_K,m_Z, 0., 0.),
spring(m_K,m_Z, 0., 0.),
nlPluck(nlK,nlScale),         par(i, 1,_)
)~par(i, 10, _):         par(i, 10,!), par(i,  1, _)
with{
RoutingLinkToMass(l0_f1,l0_f2,l1_f1,l1_f2,l2_f1,l2_f2,l3_f1,l3_f2,l4_f1,l4_f2, p_in1) = l0_f1, l0_f2+l1_f1+l3_f2, l1_f2+l2_f1+l4_f2, l2_f2+l3_f1, l4_f1, p_in1;
RoutingMassToLink(m0,m1,m2,m3,m4) = m0, m1, m1, m2, m2, m3, m3, m1, m4, m2,m3;
};
process = in1: model: *(OutGain);