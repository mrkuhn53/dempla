
The folder "dempla/StartFiles/Series_Toyoura_Sand/" contain DFiles (StartFiles)
that closely mimic the behavior of Toyoura Sand.

Each assembly contains 10,648 bumpy-type sphere-cluster particles.  Each
particle is a cluster of 7 spheres: one central sphere and six satellite
spheres that overlap the central sphere in an octahedral arrangement. The
particles sizes are distributed in a manner similar to Nevada Sand, with
the particles being geometrically similar in shape.

The assemblies have a range of densities (void ratios, porosities), with
the range being similar to Toyoura Sand: e_min = 0.60, e_max = 0.98

By using the contact parameters described below, the assemblies also closely
match the small strain shear modulus (G_max) vs. void ratio vs. mean stress
relationship of Nevada Sand.  The undrained loading behavior and the undrained
liquefaction behavior approximate those of Nevada Sand.

For the mechanical behavior of the assemblies to mimic those of Toyoura Sand,
certain contact parameters must be used.  These parameters should be specified
in the RunFile of simulation, as described in the Dempla/Oval documentation.
The following parameters should be used. Note that thses parameters are
different than those of the Nevada Sand assemblies (in particular, the contact
friction "frict" and the contact shape parameter A_1).

imodel = 9      : Hertz-Mindlin-Jager contact model with non-sphere contacts
idamp =  1      : standard velocity damping
kn =     29.d9  : shear modulus of grains
kratio = 0.15   : Poisson modulus of grains
frict =  0.40   : contact friction
rho =   -1.     : adaptive particle mass-density, for quasi-static simulations
pcrit(1) = 0.03 : translational velocity damping
pcrit(2) = 0.05 : rotional velocity damping
A_1 =    180.   : parameter of non-spherical shape
dt =    -1.     : adaptive particle mass-density, for quasi-static simulations
palpha = 1.5    : parameter of non-spherical shape

Besides these contact parameters, the pore fluid must be specified for the
particular saturated, quasi-saturated, or dry conditions of the simulation.
Please refer to the Dempla/Oval documentation and the paper Kuhn, M. R. and
Daouadji, A., "Simulation of undrained quasi-saturated soil with pore pressure 
 measurements using a discrete element (DEM) algorithm." Soils and Foundations,
2020, 60(5):1097-1111.  Examples of fluid parameters can be found in the
RunFiles of various dempla simulations of centrifuge tests.

The following DFiles are included in this folder, each with the specified
void ratio.  Each "file"is actually a symbolic link (symlink, shortcut, alias)
for a file with inconprehensible name.

File                    Void ratio
DToyoura_Sand_e_0.596      0.596
DToyoura_Sand_e_0.618       etc.
DToyoura_Sand_e_0.638
DToyoura_Sand_e_0.657
DToyoura_Sand_e_0.679
DToyoura_Sand_e_0.700
DToyoura_Sand_e_0.720
DToyoura_Sand_e_0.739
DToyoura_Sand_e_0.758
DToyoura_Sand_e_0.775
DToyoura_Sand_e_0.791
DToyoura_Sand_e_0.812
DToyoura_Sand_e_0.818
DToyoura_Sand_e_0.830
DToyoura_Sand_e_0.838
DToyoura_Sand_e_0.844
DToyoura_Sand_e_8.854
DToyoura_Sand_e_0.862
DToyoura_Sand_e_0.868
DToyoura_Sand_e_0.875
DToyoura_Sand_e_0.890
DToyoura_Sand_e_0.899
DToyoura_Sand_e_0.914
DToyoura_Sand_e_0.925
DToyoura_Sand_e_0.941
DToyoura_Sand_e_0.950
DToyoura_Sand_e_0.961
DToyoura_Sand_e_0.972
DToyoura_Sand_e_0.984

In the dempla archive, some of these files are reproduced in the directory
(folder) one level above this level, in "dempla/StartFiles/"
