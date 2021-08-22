c
c
c-----this is the 'parameter' file that prefaces most program units
c
      implicit integer*2(i-n)
      implicit double precision(a-h,o-z)
c
c
c-----parameters that are used to dimension the various arrays:
c       mdim1  - the number of spatial dimensions (2D or 3D)
c       mdim2  - the number of rotational "dimensions"
c       mp     - maximum number of particles
c       mpiece - maximum number of component pieces (for oval particles)
c       lc1    - maximum number of stress-strain control periods, 
c                should be an odd integer
c       lc2    - maximum number of force-separation data
c       ldiams - maximum number of diameters in force-separation data
c       mlist  - maximum size of the linked list of neighbors: max. number
c                of particle pairs that are near neighbors
c       mlist2 - maximum size of the linked list of contact forces: max. number
c                of particle pairs that are touching
c       mlistJ - maximum size of the linked lists for storing information
c                for Jager contacts
c       mholes - maximum number of vacancies in list of touching particles
c       mcells - maximum number of void cells in 2D topology
c       mlimbs - maximum number of edges (valence) of a void cell
c       mstack - maximum number in arrays for stress-control
c       mfiles - maximum number of output files
c       mconvx - maximum number of contacts between a pair of two particles,
c                which might be non-convex (2D or 3D)
c       mboxes - maximum nubmer of bins for finding near neighbor pairs
c       mparts - maximum number of parts in a composite 2D particle
c       mbumps - maximum number of satellite spheres in a bumpy particle
c       mLayer - maximum number of stratigraphic soil layers
c       mrve   - maximum number of nodes and RVEs in the dempla algorithm
c       mbase  - maximum number of dempla steps
c       modsav - maximum number of lines in the Mod_* file of rve moduli
c
      integer*2 lc2, ldiams,
     x          mconvx, mdiff, mdim, mdim1, mdim2, mfiles,
     x          mLayer, mlimbs, mlist3, mlists,
     x          mplatn, mpts, mrve, mstack
c
      integer*4 lc1, mbase, mboxes, mbox1, mbox2, mbox3, mbumps, mbx, 
     x          mcells, 
     x          mfirst, mholes, mlist, mlist2, mlistJ, mnear, modsav,
     x          mp, mparts, mpiece, mRock, Zero
c
c-----comment out one or the other of the following "paramater" lines
c-----2D simulations only
c     parameter (mdim1=2,mdim2=3)
c-----3D or 2D simulations simulations
      parameter (mdim1=3,mdim2=1)
c
c-----maximum number of particles
c     parameter (mp=6400)
c     parameter (mp=10648)
      parameter (mp=12000)
c     parameter (mp=129000)
c
c-----maximum number of component pieces for the "oval" 2D shape
      parameter (mpiece=4*mp)
c
c-----the number of spheres in a sphere-cluster
      parameter (mbumps=8)
c
c-----the first index of linked lists
      parameter (mfirst=0)
c-----size of near-neighbor linked lists
      parameter (mlist=mfirst+8*mp)
c
c-----convex particles
c     parameter (mlist2=16*mp/2,mholes=16*mp/2,mconvx=1)
c-----non-convex particles
      parameter (mlist2=20*mp/2,mholes=20*mp/2,mconvx=10)
      parameter (mparts=5)
      parameter (mlists=5,mlist3=mlists**2)
c
c-----number of void cell and valence of void cells (2D)
      parameter (mcells=mp*10/5,mlimbs=30)
      parameter (lc1=49999,lc2=9999)
      parameter (ldiams=20)
c
c-----parameters for use with application of body forces (legacy code)
      parameter (mdim=128*2)
c
c-----parameters for stress-control algorighm
      parameter (mstack=10)
      parameter (mdiff=1)
      parameter (mpts=100)
c
c-----binning of particles to find near-neighbors
      parameter (mboxes=mp/2,mbox1=150,mbox2=400,mbox3=40)
      parameter (mbx=mboxes+mpiece)
c
c-----number of input files
      parameter (mfiles=100)
c
c-----number of platen particles
      parameter (mplatn=3)
c
c     parameter (mlistJ=2000*mp)
c     parameter (mlistJ=8000*mp)
      parameter (mlistJ=800*mp)
c     parameter (mlistJ=200*mp)
c     parameter (mlistJ=1*mp)
c
c-----the zero indes in mlistJ (vs. 1 in Matlab)
      parameter (Zero=0)
c
c-----used in subroutin lister
      parameter (mnear=1000)
c
c-----the maximum number of entries in the rock motion file
      parameter (mRock=50000)
c
c-----limit on the number of rves (assemblies) that are analyzed
      parameter (mrve=28)
c     parameter (mrve=4)
c
c-----maximum number of stratigraphic layers
      parameter (mLayer=100)
c
c-----maximum number of dempla time steps
      parameter(mbase=1000000)
c
c-----maximum number of lines in the Mod_* file of rve moduli
      parameter(modsav=10000)
