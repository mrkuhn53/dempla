# dempla
DEMPLA means "Discrete Element Analysis for Propagation and Liquefaction Analysis".
The code can conduct two modes of simulation: (1) simulation of single DEM assemblies
(incorporating the older OVAL code);
and (2) simulation of a soil column composed of multiple DEM assemblies that serve as
the RVEs (representative volume elements) within the soil column.  In either mode,
the attempt is fidelity to the behavior or real sand specimens.  The code is intended
for quasi-static simulations of soil behavior.

The DEMPLA code includes several particle shapes (spheres, ellipses, and sphere clusters),
realistic contact models that capture the pressure-dependence of sand stiffness,
a robust servo-control mechanism the allows arbitrary control of stress or strain
components; and a poromechanic model that allows the measurement and control of
either effective or total stress and the fluid pressure.  Boundaries are periodic.
Almost arbitrary sequences of stress and strain can be simulated:
monotonic or cyclic; drained or undrained; triaxial, biaxial, simple shear, etc.; and
saturate or quasi-saturated soil.

When simulating wave propagation,
the DEMPLA code is quite general and allows one to model and understand
diverse conditions and phenomena in a one-dimensional soil column,
with input (rock) motions applied at the base:
(a) three-dimensional motions of rock and soil,
propagating as both p-waves and s-waves;
(b) nearly arbitrary stress and strain paths during
ground shaking;
(c) sloping ground surface with down-slope movement;
(d) multiple stratigraphic soil layers;
(e) sub-surface water table or complete submergence of the site;
(f) sloping water table with down-dip seepage forces;
(g) onset and depth of liquefaction;
(h) saturated soil, dry soil, or quasi-saturated soil with entrained air
at a specified saturation;
(i) dissolution or cavitation of entrained air;
(j) effect of saturation on wave propagation and liquefaction;
(k) effect of drainage that is concurrent with shaking;
(l) pore fluid with a specified viscosity;
(m) site-specific
amplification of surface accelerations relative
to those of the rock base;
(n) pressure-dependence of wave speed
and the slowing of
waves as they approach the surface;
(o) dilation and the coupling of s-waves and p-waves;
(p) voids redistribution and
development of a water film beneath less permeable layers;
(q) softening of soil during shaking,
with a slowing of wave speeds and shifting of frequency content due
to build-up of pore fluid pressure;
(r) post-shaking consolidation and settlement;
(s) post-consolidation reshaking and post-triggering behavior; and
(t) relative rise of the water table during and after shaking.

The code is written in an inelegent form of Fortran 77.
The GitHub repository includes the source code,
a detailed documentation,
sample particle assemblies,
sample input files,
sample rock motions, and
Octave (Matlab) files for analyzing the Dempla results.
For simulations of wave propagation, the code is parallelized
with the OpenMP library.
