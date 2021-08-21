      program assembly_ellipse
c
      include 'common-0.5.40'
      double precision random,x,r_avg,f_min,f_max,
     x                 facrad,fr,r1,r2,a,b,sinb,cosb,nintx,pi2,
     x                 r50,rratio,rad_1,rad_2,rdiff,
     x                 dpart,ppart,rcells,rmajor,rminor,elong,sum,
     x                 sum2,rsmall,rcomp
c
      integer circle,oval,ellips,sphere
      integer*4 ielim,iball,jball,ismall
c
      dimension a(2,2),b(2),nintx(3),rcells(3),ielim(mp)
c
      pi = 3.14159265358979323846d0
      pi2 = pi*2.d0
c
c-----establish the input file
      print *,' Which input file will be used:  '
      read (*,600) file1
c-----establish the output file
      print *,'       Name of the output file:  '
      read (*,600) file2
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
c-------the problem dimension, either 2D or 3D (ndim1=2 or 3).  'ndim2' is
c       used with rotations as the range ndim2:3.
        if(lcircl .or. loval .or. lelips) then
c---------circular, oval, or ellipse particles
          ndim1 = 2
          ndim2 = 3
        elseif(lspher .or. lovoid) then
c---------spherical or ovoid particles
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
c-----the "shear" widths
      xcell(2,1) = 0.
      xcell(3,1) = 0.
      xcell(3,2) = 0.
c
      if(ndim1.eq.2) then
        xcell(3,3) = 1.d0
        xcell(1,3) = 0.
        xcell(2,3) = 0.
      endif
c
      n = 3
      call definv(xcell,xcelli,n)
c
      do 31 iball = 1,np
        do 552 k = 1,ndim1
          rcells(k) = 0.
  552   continue
c
        do 561 k = 1,ndim1
          do 562 l = 1,ndim1
            rcells(l) = rcells(l) + xcelli(l,k) * xp(k,iball)
  562     continue
  561   continue
c
        do 564 k = 1,ndim1
          if(rcells(k).ge.0) then
            nintx(k) = int(rcells(k))
          else
            nintx(k) = int(rcells(k)) - 1.d0
          endif
  564   continue
c
        do 566 k = 1,ndim1
          do 568 l = 1,ndim1
            xp(k,iball) = xp(k,iball) - xcell(k,l)*nintx(l)
  568     continue
  566   continue
   31 continue
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
      if(lcircl .or. lspher) then
c-------for each of the (np) particles
        do 33 igrain = 1,np
          write(1,302) rad(igrain),(xp(j,igrain),j=1,ndim1)
   33   continue
      elseif(loval .or. lelips) then
        do 32 igrain = 1,np
          write(1,302) rad(igrain),aspect(igrain),
     x                 (xp(j,igrain),j=1,ndim1),
     x                 (theta(j,igrain),j=ndim2,3)
   32   continue
      elseif(lovoid) then
c
        do 69 igrain = 1,np
          write(1,305) rad(igrain),aspect(igrain),
     x                 (xp(j,igrain),j=1,ndim1),
     x                 (gamma(j,igrain),j=1,2)
   69   continue
      endif
c
      close(unit=1)
      stop
c
  300 format(i1)
  301 format(i6,3(1pE25.17))
  302 format(8(1pE25.17))
  303 format(6x,3(1pE25.17))
  305 format(   4(1pe25.17),/,3(1pe25.17))
  600 format(a80)
c
  311 format(i6,3(1pE25.17))
  312 format(   8(1pE25.17))
  313 format(6x,3(1pE25.17))
c
      end
c
      subroutine definv(a,ai,n)
c
c-----this subroutin computes the inverse of the deformation matrix (actually,
c     the deformation gradient matrix)
c
      implicit double precision(a-h,o-z)
      implicit integer*2(i-n)
      parameter(m=3)
      dimension a(m,m),ai(m,m),b(m,m)
c
      do 11 i = 1,n
        do 12 j = 1,n
          b(i,j) = a(i,j)
          ai(i,j) = 0.
   12   continue
        ai(i,i) = 1.d0
   11 continue
c
      do 10 i = 1,n-1
        do 20 j = i+1,n
          factor = -(b(j,i) / b(i,i))
          do 32 k = 1,n
            ai(j,k) = ai(j,k) + ai(i,k) * factor
            b(j,k) = b(j,k) + b(i,k) * factor
   32     continue
   20   continue
   10 continue
c
      do 50 i = n,2,-1
        do 52 j = i-1,1,-1
          factor = -(b(j,i) / b(i,i))
          do 54 k = 1,n
            ai(j,k) = ai(j,k) + ai(i,k) * factor
            b(j,k) = b(j,k) + b(i,k) * factor
   54     continue
   52   continue
   50 continue
c
      do 30 i = 1,n
        factor = b(i,i)
        do 40 j = 1,n
          ai(i,j) = ai(i,j) / factor
          b(i,j) = b(i,j) / factor
   40   continue
   30 continue
c
      end
