
The folder "dempla/StartFiles/Series_Nevada_Sand/" contain DFiles (StartFiles)
that closely mimic the behavior of Nevada Sand.

Each assembly contains 10,648 bumpy-type sphere-cluster particles.  Each
particle is a cluster of 7 spheres: one central sphere and six satellite
spheres that overlap the central sphere in an octahedral arrangement. The
particles sizes are distributed in a manner similar to Nevada Sand, with
the particles being geometrically similar in shape.

The assemblies have a range of densities (void ratios, porosities), with
the range being similar to Nevada Sand.  Although other ranges have been
reported, the range of Arulmoli are as follows:  e_min = 0.511, e_max = 0.894

By using the contact parameters described below, the assemblies also closely
match the small strain shear modulus (G_max) vs. void ratio vs. mean stress
relationship of Nevada Sand.  The undrained loading behavior and the undrained
liquefaction behavior approximate those of Nevada Sand.

For the mechanical behavior of the assemblies to mimic those of Nevada Sand,
certain contact parameters must be used.  These parameters should be specified
in the RunFile of simulation, as described in the Dempla/Oval documentation.
The following parameters should be used. Note that thses parameters are
different than those of the Toyoura Sand assemblies (in particular, the contact
friction "frict" and the contact shape parameter A_1).

imodel = 9      : Hertz-Mindlin-Jager contact model with non-sphere contacts
idamp =  1      : standard velocity damping
kn =     29.d9  : shear modulus of grains
kratio = 0.15   : Poisson modulus of grains
frict =  0.40   : contact friction
rho =   -1.     : adaptive particle mass-density, for quasi-static simulations
pcrit(1) = 0.03 : translational velocity damping
pcrit(2) = 0.05 : rotional velocity damping
A_1 =    100.   : parameter of non-spherical shape
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

File                  Void ratio
DNevada_Sand_e_0.511   0.511
DNevada_Sand_e_0.523    etc.
DNevada_Sand_e_0.545
DNevada_Sand_e_0.557
DNevada_Sand_e_0.566
DNevada_Sand_e_0.578
DNevada_Sand_e_0.586
DNevada_Sand_e_0.596
DNevada_Sand_e_0.607
DNevada_Sand_e_0.617
DNevada_Sand_e_0.628
DNevada_Sand_e_0.639
DNevada_Sand_e_0.646
DNevada_Sand_e_0.655
DNevada_Sand_e_0.667
DNevada_Sand_e_0.674
DNevada_Sand_e_0.684
DNevada_Sand_e_0.695
DNevada_Sand_e_0.707
DNevada_Sand_e_0.716
DNevada_Sand_e_0.725
DNevada_Sand_e_0.733
DNevada_Sand_e_0.742
DNevada_Sand_e_0.759
DNevada_Sand_e_0.768
DNevada_Sand_e_0.773
DNevada_Sand_e_0.785
DNevada_Sand_e_0.792
DNevada_Sand_e_0.802
DNevada_Sand_e_0.809
DNevada_Sand_e_0.818
DNevada_Sand_e_0.825
DNevada_Sand_e_0.843
DNevada_Sand_e_0.857
DNevada_Sand_e_0.869
DNevada_Sand_e_0.882
DNevada_Sand_e_0.892

In the dempla archive, some of these files are reproduced in the directory
(folder) one level above this level, in "dempla/StartFiles/"
