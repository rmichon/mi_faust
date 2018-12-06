 
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
spring(k,z,x1,x2) = k*(x1-x2) + z*((x1-x1')-(x2-x2')) <: _*-1,_;

// nlPluck
// 1D non-linear picking Interaction algorithm
nlPluck(k,scale,x1,x2) = 
  select2(
    absdeltapos>scale,
    select2(
      absdeltapos>scale*0.5,
      k*deltapos,
      k*(ma.signum(deltapos)*scale*0.5-deltapos)),
    0) <:  _*-1,_
with{
  deltapos = x1 - x2;
  absdeltapos = abs(deltapos);
};

// nlBow
// 1D non-linear bowing Interaction algorithm 
// JL: corrected error: force = 0 if beyond the scale distance value
nlBow(z,scale,x1,x2) = 
	select2(
	  absspeed < (scale/3),
  	  z*speed,
	  select2(
		absspeed<scale,
		select2(
		  speed>0,
		  (scale/3)*z + (-z/4)*speed,
		  (-scale/3)*z + (-z/4)*speed
		  ),
		0
		)
	  ) <:   _*-1,_
with{
  speed = (x1-x1') - (x2-x2');
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

low_M = 1.0;
low_K = 0.5;
low_Z = 0.001;
nlK = 0.08;
nlscale = 0.01;

model = (RoutingLinkToMass, _: 
ground(0.),
ground(0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
mass(low_M,0., 0.),
posInput(0.) :
RoutingMassToLink : 
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
spring(low_K,low_Z),
nlPluck(nlK,nlscale),         par(i, 2,_))~par(i, 304, _):         par(i, 304,!), par(i,  2, _)
with{
RoutingLinkToMass(l0_f1,l0_f2,l1_f1,l1_f2,l2_f1,l2_f2,l3_f1,l3_f2,l4_f1,l4_f2,l5_f1,l5_f2,l6_f1,l6_f2,l7_f1,l7_f2,l8_f1,l8_f2,l9_f1,l9_f2,l10_f1,l10_f2,l11_f1,l11_f2,l12_f1,l12_f2,l13_f1,l13_f2,l14_f1,l14_f2,l15_f1,l15_f2,l16_f1,l16_f2,l17_f1,l17_f2,l18_f1,l18_f2,l19_f1,l19_f2,l20_f1,l20_f2,l21_f1,l21_f2,l22_f1,l22_f2,l23_f1,l23_f2,l24_f1,l24_f2,l25_f1,l25_f2,l26_f1,l26_f2,l27_f1,l27_f2,l28_f1,l28_f2,l29_f1,l29_f2,l30_f1,l30_f2,l31_f1,l31_f2,l32_f1,l32_f2,l33_f1,l33_f2,l34_f1,l34_f2,l35_f1,l35_f2,l36_f1,l36_f2,l37_f1,l37_f2,l38_f1,l38_f2,l39_f1,l39_f2,l40_f1,l40_f2,l41_f1,l41_f2,l42_f1,l42_f2,l43_f1,l43_f2,l44_f1,l44_f2,l45_f1,l45_f2,l46_f1,l46_f2,l47_f1,l47_f2,l48_f1,l48_f2,l49_f1,l49_f2,l50_f1,l50_f2,l51_f1,l51_f2,l52_f1,l52_f2,l53_f1,l53_f2,l54_f1,l54_f2,l55_f1,l55_f2,l56_f1,l56_f2,l57_f1,l57_f2,l58_f1,l58_f2,l59_f1,l59_f2,l60_f1,l60_f2,l61_f1,l61_f2,l62_f1,l62_f2,l63_f1,l63_f2,l64_f1,l64_f2,l65_f1,l65_f2,l66_f1,l66_f2,l67_f1,l67_f2,l68_f1,l68_f2,l69_f1,l69_f2,l70_f1,l70_f2,l71_f1,l71_f2,l72_f1,l72_f2,l73_f1,l73_f2,l74_f1,l74_f2,l75_f1,l75_f2,l76_f1,l76_f2,l77_f1,l77_f2,l78_f1,l78_f2,l79_f1,l79_f2,l80_f1,l80_f2,l81_f1,l81_f2,l82_f1,l82_f2,l83_f1,l83_f2,l84_f1,l84_f2,l85_f1,l85_f2,l86_f1,l86_f2,l87_f1,l87_f2,l88_f1,l88_f2,l89_f1,l89_f2,l90_f1,l90_f2,l91_f1,l91_f2,l92_f1,l92_f2,l93_f1,l93_f2,l94_f1,l94_f2,l95_f1,l95_f2,l96_f1,l96_f2,l97_f1,l97_f2,l98_f1,l98_f2,l99_f1,l99_f2,l100_f1,l100_f2,l101_f1,l101_f2,l102_f1,l102_f2,l103_f1,l103_f2,l104_f1,l104_f2,l105_f1,l105_f2,l106_f1,l106_f2,l107_f1,l107_f2,l108_f1,l108_f2,l109_f1,l109_f2,l110_f1,l110_f2,l111_f1,l111_f2,l112_f1,l112_f2,l113_f1,l113_f2,l114_f1,l114_f2,l115_f1,l115_f2,l116_f1,l116_f2,l117_f1,l117_f2,l118_f1,l118_f2,l119_f1,l119_f2,l120_f1,l120_f2,l121_f1,l121_f2,l122_f1,l122_f2,l123_f1,l123_f2,l124_f1,l124_f2,l125_f1,l125_f2,l126_f1,l126_f2,l127_f1,l127_f2,l128_f1,l128_f2,l129_f1,l129_f2,l130_f1,l130_f2,l131_f1,l131_f2,l132_f1,l132_f2,l133_f1,l133_f2,l134_f1,l134_f2,l135_f1,l135_f2,l136_f1,l136_f2,l137_f1,l137_f2,l138_f1,l138_f2,l139_f1,l139_f2,l140_f1,l140_f2,l141_f1,l141_f2,l142_f1,l142_f2,l143_f1,l143_f2,l144_f1,l144_f2,l145_f1,l145_f2,l146_f1,l146_f2,l147_f1,l147_f2,l148_f1,l148_f2,l149_f1,l149_f2,l150_f1,l150_f2,l151_f1,l151_f2) = l0_f1, l150_f2, l0_f2+l1_f1, l1_f2+l2_f1, l2_f2+l3_f1, l3_f2+l4_f1, l4_f2+l5_f1, l5_f2+l6_f1, l6_f2+l7_f1, l7_f2+l8_f1, l8_f2+l9_f1, l9_f2+l10_f1, l10_f2+l11_f1, l11_f2+l12_f1, l12_f2+l13_f1, l13_f2+l14_f1, l14_f2+l15_f1, l15_f2+l16_f1, l16_f2+l17_f1, l17_f2+l18_f1, l18_f2+l19_f1, l19_f2+l20_f1, l20_f2+l21_f1, l21_f2+l22_f1, l22_f2+l23_f1, l23_f2+l24_f1, l24_f2+l25_f1, l25_f2+l26_f1, l26_f2+l27_f1, l27_f2+l28_f1, l28_f2+l29_f1, l29_f2+l30_f1, l30_f2+l31_f1, l31_f2+l32_f1, l32_f2+l33_f1, l33_f2+l34_f1, l34_f2+l35_f1, l35_f2+l36_f1, l36_f2+l37_f1, l37_f2+l38_f1, l38_f2+l39_f1, l39_f2+l40_f1, l40_f2+l41_f1, l41_f2+l42_f1, l42_f2+l43_f1, l43_f2+l44_f1, l44_f2+l45_f1, l45_f2+l46_f1, l46_f2+l47_f1, l47_f2+l48_f1, l48_f2+l49_f1, l49_f2+l50_f1, l50_f2+l51_f1, l51_f2+l52_f1, l52_f2+l53_f1, l53_f2+l54_f1, l54_f2+l55_f1, l55_f2+l56_f1, l56_f2+l57_f1, l57_f2+l58_f1, l58_f2+l59_f1, l59_f2+l60_f1, l60_f2+l61_f1, l61_f2+l62_f1, l62_f2+l63_f1, l63_f2+l64_f1, l64_f2+l65_f1, l65_f2+l66_f1, l66_f2+l67_f1, l67_f2+l68_f1, l68_f2+l69_f1, l69_f2+l70_f1, l70_f2+l71_f1, l71_f2+l72_f1, l72_f2+l73_f1, l73_f2+l74_f1, l74_f2+l75_f1, l75_f2+l76_f1, l76_f2+l77_f1, l77_f2+l78_f1, l78_f2+l79_f1, l79_f2+l80_f1, l80_f2+l81_f1, l81_f2+l82_f1, l82_f2+l83_f1, l83_f2+l84_f1, l84_f2+l85_f1, l85_f2+l86_f1, l86_f2+l87_f1, l87_f2+l88_f1, l88_f2+l89_f1, l89_f2+l90_f1, l90_f2+l91_f1, l91_f2+l92_f1, l92_f2+l93_f1, l93_f2+l94_f1, l94_f2+l95_f1, l95_f2+l96_f1, l96_f2+l97_f1, l97_f2+l98_f1, l98_f2+l99_f1, l99_f2+l100_f1, l100_f2+l101_f1, l101_f2+l102_f1, l102_f2+l103_f1, l103_f2+l104_f1, l104_f2+l105_f1, l105_f2+l106_f1, l106_f2+l107_f1, l107_f2+l108_f1, l108_f2+l109_f1, l109_f2+l110_f1, l110_f2+l111_f1, l111_f2+l112_f1, l112_f2+l113_f1, l113_f2+l114_f1, l114_f2+l115_f1, l115_f2+l116_f1, l116_f2+l117_f1, l117_f2+l118_f1, l118_f2+l119_f1, l119_f2+l120_f1, l120_f2+l121_f1, l121_f2+l122_f1, l122_f2+l123_f1, l123_f2+l124_f1, l124_f2+l125_f1, l125_f2+l126_f1, l126_f2+l127_f1, l127_f2+l128_f1, l128_f2+l129_f1, l129_f2+l130_f1, l130_f2+l131_f1, l131_f2+l132_f1, l132_f2+l133_f1, l133_f2+l134_f1, l134_f2+l135_f1, l135_f2+l136_f1, l136_f2+l137_f1, l137_f2+l138_f1, l138_f2+l139_f1, l139_f2+l140_f1, l140_f2+l141_f1+l151_f2, l141_f2+l142_f1, l142_f2+l143_f1, l143_f2+l144_f1, l144_f2+l145_f1, l145_f2+l146_f1, l146_f2+l147_f1, l147_f2+l148_f1, l148_f2+l149_f1, l149_f2+l150_f1, l151_f1;
RoutingMassToLink(m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18,m19,m20,m21,m22,m23,m24,m25,m26,m27,m28,m29,m30,m31,m32,m33,m34,m35,m36,m37,m38,m39,m40,m41,m42,m43,m44,m45,m46,m47,m48,m49,m50,m51,m52,m53,m54,m55,m56,m57,m58,m59,m60,m61,m62,m63,m64,m65,m66,m67,m68,m69,m70,m71,m72,m73,m74,m75,m76,m77,m78,m79,m80,m81,m82,m83,m84,m85,m86,m87,m88,m89,m90,m91,m92,m93,m94,m95,m96,m97,m98,m99,m100,m101,m102,m103,m104,m105,m106,m107,m108,m109,m110,m111,m112,m113,m114,m115,m116,m117,m118,m119,m120,m121,m122,m123,m124,m125,m126,m127,m128,m129,m130,m131,m132,m133,m134,m135,m136,m137,m138,m139,m140,m141,m142,m143,m144,m145,m146,m147,m148,m149,m150,m151,m152) = m0, m2, m2, m3, m3, m4, m4, m5, m5, m6, m6, m7, m7, m8, m8, m9, m9, m10, m10, m11, m11, m12, m12, m13, m13, m14, m14, m15, m15, m16, m16, m17, m17, m18, m18, m19, m19, m20, m20, m21, m21, m22, m22, m23, m23, m24, m24, m25, m25, m26, m26, m27, m27, m28, m28, m29, m29, m30, m30, m31, m31, m32, m32, m33, m33, m34, m34, m35, m35, m36, m36, m37, m37, m38, m38, m39, m39, m40, m40, m41, m41, m42, m42, m43, m43, m44, m44, m45, m45, m46, m46, m47, m47, m48, m48, m49, m49, m50, m50, m51, m51, m52, m52, m53, m53, m54, m54, m55, m55, m56, m56, m57, m57, m58, m58, m59, m59, m60, m60, m61, m61, m62, m62, m63, m63, m64, m64, m65, m65, m66, m66, m67, m67, m68, m68, m69, m69, m70, m70, m71, m71, m72, m72, m73, m73, m74, m74, m75, m75, m76, m76, m77, m77, m78, m78, m79, m79, m80, m80, m81, m81, m82, m82, m83, m83, m84, m84, m85, m85, m86, m86, m87, m87, m88, m88, m89, m89, m90, m90, m91, m91, m92, m92, m93, m93, m94, m94, m95, m95, m96, m96, m97, m97, m98, m98, m99, m99, m100, m100, m101, m101, m102, m102, m103, m103, m104, m104, m105, m105, m106, m106, m107, m107, m108, m108, m109, m109, m110, m110, m111, m111, m112, m112, m113, m113, m114, m114, m115, m115, m116, m116, m117, m117, m118, m118, m119, m119, m120, m120, m121, m121, m122, m122, m123, m123, m124, m124, m125, m125, m126, m126, m127, m127, m128, m128, m129, m129, m130, m130, m131, m131, m132, m132, m133, m133, m134, m134, m135, m135, m136, m136, m137, m137, m138, m138, m139, m139, m140, m140, m141, m141, m142, m142, m143, m143, m144, m144, m145, m145, m146, m146, m147, m147, m148, m148, m149, m149, m150, m150, m151, m151, m1, m152, m142,m22,m12;
};
process = hslider("position",1,-1,1,0.0001) : si.smoo : model: *(20.), *(20.);