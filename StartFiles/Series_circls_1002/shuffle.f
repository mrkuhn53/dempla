      program shuffle
c
c-----this utility program will scale the size of an assembly. NOTE that
c     scales both the particles and the assembly.
c       1) input is from a D-type StartFile
c       2) output is to a  D-type StartFile
c       3) it will adjust the scale by any of three methods
c            a) scaled by a given input value of "scale"
c            b) scaled so that the D50 size (diameter) is the same as a 
c               given input value of D50.  It is important to understand 
c               that D50 is defined in the geotechnical sense:  it is 
c               the opening size in a square sieve that 50% of the 
c               mass of the assembly would pass through.  It
c               is NOT the median or mean particle size.  For ovoid
c               particles, we use the girth diameter (the diameter
c               transverse to the revolved axis of the ovoid), whether
c               the ovoid is prolate or oblate.  For ovals and ellipses,
c               we use the minimum diameter of the particle.
c            c) scaled so that the meain diameter is that same as
c               a given input value.
c
      include 'common-0.5.43'
c
      integer*4 igrain,ishift,jgrain,n
      logical lcatch
c
      pi = 3.14159265358979323846d0
c
c-----establish the input file
      print *,' Which input file will be used:  '
      read (*,600) file1
c-----establish the output file
      print *,'       Name of the output file:  '
      read (*,600) file2
c
c-----scaling method
      print *,' The shift integer:'
      read *,ishift
c
      open(unit=1,file=file1)
c
      read(1,300) kshape
c
      lcircl = kshape.eq.1
c-----four-arc (2D) ovals
      loval =  kshape.eq.2
c-----elliptical (2D) disks
      lelips = kshape.eq.3
c-----spheres (3D)
      lspher = kshape.eq.4
c-----ovoids (3D)
      lovoid = kshape.eq.5
c
c-----the problem dimension, either 2D or 3D (ndim1=2 or 3).  'ndim2' is
c     used with rotations as the range ndim2:3.
      if(lcircl .or. loval .or. lelips) then
c-------circular, oval, or ellipse particles
        ndim1 = 2
        ndim2 = 3
      elseif(lspher .or. lovoid) then
c-------spherical or ovoid particles
        ndim1 = 3
        ndim2 = 1
      endif
c
      read(1,*) np,(xcell(i,i),i=1,3)
      read(1,*) xcell(1,2),xcell(1,3),xcell(2,3)
c
      if(loval .or. lovoid) then
c-------for these composite particles read the angle 'beta' (in degrees)
c       which describes how the component pieces are joined
        read(1,*) beta
      endif
c
      if(lcircl .or. lspher) then
c-------circular disks or spheres
c
c-------for each particle, read the radius and position
        do 20 igrain = 1,np
c---------note the use of the range 1:ndim1, where ndim1 is the dimension
c         of the problem (ndim1=2 for 2D problems, ndim1=3 for 3D problems)
          read(1,*) rad(igrain),(xp(j,igrain),j=1,ndim1)
   20   continue
      elseif(loval.or.lelips) then
c-------2D ovals or elliptical particles
c
c-------for each oval (or ellipse), read
c         the lateral radius,
c         the ratio of axial/lateral radii,
c         the position of the center of the oval (or ellipse), and
c         the orientation (in degrees) of the axial axis relative to
c           vertical (measured counter-clockwise).
c
        do 30 igrain = 1,np
          read(1,*) rad(igrain),aspect(igrain),
     x                (xp(j,igrain),j=1,ndim1),
     x                (theta(j,igrain),j=ndim2,3)
   30   continue
      elseif(lovoid) then
c-------3D ovoid particles
c
c-------for each ovoid read
c         the revolved radius,
c         the ratio of axial radius / revolved radius (R_1/R_2,
c            (a value greater than zero)
c         the position of the center of the ovoid (X),
c         the orientation (in degrees) of the particle axis
c           relative to the positive x-3 direction, and
c         the orientation (in degrees) of the particle axis about
c           the x-1 axis (measured counter-clockwise)
        do 51 igrain = 1,np
          read(1,*) rad(igrain),aspect(igrain),
     x                (xp(j,igrain),j=1,ndim1),
     x                (gamma(j,igrain),j=1,2)
   51   continue
      endif
c
      close(unit=1)
c
      open(unit=1,file=file2)
c
      write(1,300) kshape
      write(1,311) np,(xcell(i,i),i=1,3)
      write(1,313) xcell(1,2),xcell(1,3),xcell(2,3)
c
      if(loval .or. lovoid) then
        write(1,312) beta
      endif
c
c-----for each of the (np) particles
      do 33 igrain = 1,np
        jgrain = igrain + ishift
        jgrain = nwmod4(jgrain,np)
        if(jgrain.eq.0) then
          jgrain = np
        endif
        if(lcircl .or. lspher) then
            write(1,302) rad(jgrain),(xp(j,igrain),j=1,ndim1)
        elseif(loval .or. lelips) then
            write(1,302) rad(jgrain),aspect(igrain),
     x                  (xp(j,igrain),j=1,ndim1),
     x                  (theta(j,igrain),j=ndim2,3)
        elseif(lovoid) then
            write(1,305) rad(jgrain),aspect(igrain),
     x                  (xp(j,igrain),j=1,ndim1),
     x                  (gamma(j,igrain),j=1,2)
        endif
   33 continue
c
      close(unit=1)
      stop
c
  300 format(i1)
  301 format(i6,3(1pE25.17))
  302 format(8(1pE25.17))
  303 format(6x,3(1pE25.17))
  305 format(   7(1pe25.17))
  600 format(a80)
c
  311 format(i6,3(1pE25.17))
  312 format(   8(1pE25.17))
  313 format(6x,3(1pE25.17))
c
      end
c
c
c*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
      integer*4 function nwmod4(i,j)
        integer*4 i,j
        nwmod4 = mod(i,j)
        if(nwmod4.lt.0) nwmod4 = nwmod4 + j
      end
