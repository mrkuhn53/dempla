c
c
c-----this is the 'common' file that prefaces most program units
c
c-----these implicits are established in the "param-dempla-X.X.XX" file
c     implicit integer*2(i-n)
c     implicit double precision(a-h,o-z)
c
      double precision  A_1,adtm,alpha_d,ambtmp,athdtm,
     x                  a_vect,ainteg,avasp,
     x                  b_rad,BaseDepth,boltzman,
     x                  C_11nu,C_factor,
     x                  cenrad,centrifuge,cirrad,chia1,chidat,
     x                  cosin_s,cosin_w,
     x                  Cn,Cn_1,cosa,
     x                  D_o,ddef_target,ddefwm,def,
     x                  defrat,defratl,defw,defwold,
     x                  dele,dfunc6,dfunc7,dfunc7i,DepthNode,DepthRVE,
     x                  Dip_soil,Dip_water,Direct_soil,Direct_water,
     x                  dtRock,dx_rve,
     x                  Dlast,dpfluid,
     x                  dslidet,dsold1,dtfctr,dtinp,dvctrl,
     x                  Ebar,Ebar23n,Ebar43n,
     x                  EffStressRVE,eps_grad,epsd,etargt,
     x                  fpnrgy,frict_sav,frictm,
     x                  func6,func7,func7i,
     x                  G,G_s,gaccel,gamm,gravty,Gbar,grav,h_rho,Hcc,
     x                  Iavg,Imean,Integ_rho_s,Integ_rho_f,
     x                  k_a,K_f,k_geot,K_s,k_w,kappa,kbulk,
     x                  kmdat,kmean,kn,knh,knmax,
     x                  knrgy,knrgyo,knsep2,knseph,
     x                  kratio,Ks,kt,kth,kthh,Kw,
     x                  LayerBottom,LayerThickness,
     x                  lambda,l_i_old,lPorosity, lvoidno,
     x                  mass,massav,massd,massdat,massit,
     x                  mnt,mnt2,mntav,mntit,
     x                  N_o,n1,nu,
     x                  ovravg,ovrdat,ovrsav,ovravgz,ovrsavz,
     x                  p_atm,p_o,p_RVE,p_vap,p_wcav,
     x                  palpha,pCap,pdat,pfluid,pfluido,
     x                  planck,poros0,porosn,
     x                  q,q_alt,Qc_old,Qp,
     x                  rho_a,rho_dry,rho_sat,rho_w,
     x                  rdampa,rgas,rhoinp,rin,rout,
     x                  S_now,S_o,s_rad,satrad,
     x                  Slope_1,Slope_2,spheat,spnrgy,
     x                  streff,stres0,stress,
     x                  stro,strtot,
     x                  strwold,
     x                  t_PostShake, t_Setl,tdampa,tdepf,tempr, temprt,
     x                  tmax,tolQ,TotStressRVE,tRockalt,Tstar,
     x                  u_wcav,
     x                  v_p,vcellt,visc_a,visc_w,vmnt_p,
     x                  voidn,voidno,
     x                  VoidRatio,volavg,volmin,VolumQ,vrate,
     x                  WaterDepth,workc,
     x                  x1Rockalt,x2Rockalt,x3Rockalt,
     x                  xCap,xi_old,xLayerBottom,xlocal,
     x                  xNode,xRock,xRVE,xSat,xWater,
     x                  y2_1Rock,y2_2Rock,y2_3Rock
c
      integer*2         algori,AUnit,botrve,BUnit,Bversn,countr,ErrUnit,
     x                  iABfile,iCap,Isotropic,hmodel,
     x                  icoef,idamp,idumpi,ifrctnl,iheat,
     x                  ip1cnt,ip2cnt,iporo,iPreProcess,iqcntr,
     x                  iRunLayer_DEM,iRunRVE_DEM,iRunRVEModuli,
     x                  ischeme,ishrtn,iSystem,ivers,jCap,
     x                  LayerRVE,listf1,listf2,lSat,lvers,
     x                  nbumps,ndat,nDEM_out,nDempla_out,
     x                  nLayers,nobs,npnts_xtra,nRVEs,nslidc,quad,
     x                  ScrUnit,topdif
c
      integer*4         box,boxi,
     x                  f1,f2,hole,hf,hv,
     x                  icontl,icontp,icontpl,icontr,icornw,ihole,
     x                  iouti,ipoint,ipt2,ipt4,
     x                  iptbx1,iptbx2,
     x                  istep,istep2,istepa,istepm,isub,itime,itrack,
     x                  lfaces,list1,list2,listb,liste,listf0,loopst,
     x                  medges,merror,
     x                  mvers,
     x                  nbox,nboxes,
     x                  ncells,ncownt,ndim1,ndim2,nerror,
     x                  nfilled,nnear,np,np2,npiece,
     x                  nRock,nRockalt,nslide,nsteps_min,
     x                  ntacts,ntactz,nTiltEquil,nTiltSteps,nupdat4,
     x                  nverts,
     x                  p1,p2,v1,v2
c
      logical           l3d,lABfile,lanch,lApprox,laxsym,
     x                  lbody,lbodyf,lbumpy,lcdamp,
     x                  lcircl,lcirc1,lcirc2,lcirc3,lcirct,lconvx,
     x                  ldat,ldefrm,ldirec,ldrain,
     x                  lelips,lexact,
     x                  lFindModuli,lflag1,lfrict,
     x                  lgrav,lHertz,lhiddn,
     x                  linit,linitc,linitf,liso,liso2,
     x                  lJager,lJagr2,lJagr3,lJagr4,
     x                  llast,lmove,lnew,lnewc,lnewdt,lnobby,
     x                  lout,loval,lovoid,lovrid,lplatn,lplold,lplotd,
     x                  lporo,lupdat,lqcntr,lquez,
     x                  lreprt,lreset,lrotat,
     x                  lScreen,
     x                  lsinh,lspher,lsphr,
     x                  ltheta,lthfix,ltotal,ltrick,lvctrl,lwalls,
     x                  lxiold
c
      character*400     apend,cVar,
     x                  file1,file2,file3,MainDir,RockMotionFile,
     x                  RunFileLayer,StartFileLayer
      character*800     RunFilePath,StartFilePath
      character*72      title
      character*40      partyp
      character*24      version
      character*4       cstep
c     character*1       PathSep
c
c
c-----parameters that are used to dimension the various arrays.  The values
c     of these implicits are established in the "param-dempla-X.X.XX" file
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
c       mdim1  - the number of spatial dimensions (2D or 3D)
c       mdim2  - the number of rotational "dimensions"
c       mfiles - maximum number of output files
c       mconvx - maximum number of contacts between a pair of two particles,
c                which might be non-convex (2D or 3D)
c       mparts - maximum number of parts in a composite 2D particle
c       mbumps - maximum number of satellite spheres in a bumpy particle
c       mLayer - maximum number of stratigraphic soil layers
c
c-----comment out one or the other of the following "paramater" lines
c-----2D simulations only
c     parameter (mdim1=2,mdim2=3)
c
c-----3D or 2D simulations simulations
c     parameter (mdim1=3,mdim2=1)
c
c-----maximum number of particles
c     parameter (mp=6400)
c     parameter (mp=12000)
c
c     parameter (mLayer=100)
c
c     parameter (mpiece=4*mp)
c     parameter (mfirst=0)
c     parameter (mlist=mfirst+8*mp)
c-----convex particles
c     parameter (mlist2=16*mp/2,mholes=16*mp/2,mconvx=1)
c-----non-convex particles
c     parameter (mlist2=20*mp/2,mholes=20*mp/2,mconvx=10)
c     parameter (mparts=5)
c     parameter (mlists=5,mlist3=mlists**2)
c
c     parameter (mcells=mp*10/5,mlimbs=30)
c     parameter (mstack=10,lc1=9999,lc2=9999,ldiams=20)
c
c-----limit on the number of rves (assemblies) that are analyzed
c     parameter (mrve=4)
c
c-----parameters for use with application of body forces
c     parameter (mdim=128*2)
c
c     parameter (mdiff=1)
c     parameter (mpts=100)
c
c     parameter (mboxes=mp/2,mbox1=150,mbox2=400,mbox3=40)
c     parameter (mbx=mboxes+mpiece)
c     parameter (mfiles=100)
c     parameter (mplatn=3)
c
c     parameter (mlistJ=8000*mp)
c     parameter (mlistJ=800*mp)
c     parameter (mlistJ=1*mp)
c
c     parameter (mbumps=8)
c
c-----used in subroutin lister
c     parameter (mnear=1000)
c
c-----the maximum number of entries in the rock motion file
c     parameter (mRock=10000)
c
c     parameter (Zero=0)
c
c Double precision arrays:
      common ainteg(-1:2),a_vect(3,mp,0:mrve),aspect(mp,0:mrve)
      common b_rad(0:mbumps,0:mrve)
      common branch(2,0:mlist2,0:mrve)
      common c_etas(3,0:mlist2,0:mrve),cbeta(mdim1,0:mrve)
      common cosa(mparts,3,0:mrve),cosin_s(3),cosin_w(3)
      common cosxl(2,0:mlist2,0:mrve),ctheta(mdim1,mp,0:mrve)
      common ddefwm(0:mrve)
      common ddef(8,0:mrve),ddefh(3,0:mrve),ddefho(3,0:mrve)
      common ddefme(3,3,0:mrve)
      common def(3,3,0:mrve),defdot(0:lc1,0:mrve)
      common defo(3,3,0:mrve)
      common defold(3,3,0:mrve),defp(3,0:3)
      common defrat(8,0:lc1,0:mrve),defratl(8,0:mrve)
      common defup(3,0:mrve),defv(0:8,0:mrve)
      common deftot(3,3),defttn(3,3),defttt(3,3)
      common deftt1(3,3),deftt2(3,3),deftt3(3,3),defclt(3,3)
      common ds(8,0:mrve),dsfals(8+mdiff,mstack,0:mrve)
      common dsold1(0:mlist2,0:mrve)
      common dsreal(8+mdiff,mstack,0:mrve),dstres(8,0:mrve)
      common dtfctr(0:mrve)
      common ddth(mdim2:3,mp,0:mrve),dth(mdim2:3,mp,0:mrve)
      common dx(mdim1,mp,0:mrve),dxcell(3,3,0:mrve)
c
      common EffStressRVE(3,0:mrve),eperm(3,3,3)
      common f(mdim1,mp,0:mrve)
      common finalv(0:lc1,0:mrve),fnold1(0:mlist2,0:mrve)
      common fth(mdim2:3,mp,0:mrve),ftold(mdim1,0:mlist2,0:mrve)
      common func1(0:mpts),func2(0:mpts),func3(0:mpts+1)
      common func4(0:mpts+1),func5(0:mpts+1)
      common func6(0:mpts+1),func7(0:mpts+1),func7i(0:mpts+1)
      common G_s(mLayer),gaccel(3),gamma_(3,mp,0:mrve),gravty(3)
      common Integ_rho_f(0:mrve),Integ_rho_s(0:mrve)
      common l_i_old(mdim1,0:mlist2,0:mrve)
      common mass(1:mp,0:mrve),mnt(1:mp,0:mrve),mnt2(1:mp,0:mrve)
      common p_RVE(0:mrve)
      common pCap(0:mrve),pcrit(3,0:mrve),pforce(0:lc2,0:ldiams)
      common psep(0:lc2,0:ldiams)
      common q(8,8,0:mrve),q_alt(8,8,0:mrve),Qc_old(4,0:mlist2,0:mrve)
      common qdef(8,0:mrve),qi(8,8,0:mrve)
      common Qp(4,mp,0:mrve)
      common rad(mp,0:mrve),r_piec(4,mp,0:mrve)
c
      common s(8,0:mrve),s_rad(0:mbumps,0:mrve)
      common sepdia(0:ldiams)
      common str(0:8,0:mrve),stranc(3,0:mrve),streff(8,0:mrve)
      common stres0(3,3,0:mrve),stress(3,3,0:mrve)
      common streso(8,0:mrve)
      common strtot(8,0:mrve),dstI(3,3)
      common dstII(3,3),dstIIa(3,3),dstIIb(3,3),dstIIc(3,3),dstIId(3,3)
      common dstII1(3,3),dstII2(3,3),dstII3(3,3),dstII4(3,3)
      common dstIII(3,3),dstIIIa(3,3),dstIIIc(3,3),dstIIId(3,3)
      common dstIII1(3,3),dstIII2(3,3),dstIII3(3,3),dstIII4(3,3)
      common dstIV(3,3)
      common stro(8,0:mrve),strold(3,3,0:mrve)
      common tempr(mp,0:mrve)
c     common th(0:mdim-1)
      common theta(mdim2:3,mp,0:mrve)
      common thmove(mdim2:3,mp,0:mrve)
      common tolrnc(2,0:mrve),TotStressRVE(0:mrve)
      common tRockalt(mRock+1),Tstar(0:mlist2,0:mrve)
c
      common u_wcav(0:mrve)
      common v_p(mp,0:mrve),vmnt_p(mp,0:mrve)
      common vh(mdim1,mp,0:mrve),vhth(mdim2:3,mp,0:mrve)
      common VoidRatio(mLayer),vrate(0:lc1,0:mrve)
      common x1Rockalt(mRock+1),x2Rockalt(mRock+1),x3Rockalt(mRock+1)
      common xCap(mLayer)
      common xlocal(0:mbumps,3,0:mrve)
      common xp(mdim1,mp,0:mrve)
      common xcell(3,3,0:mrve),xcelle(3,0:mrve)
      common xcelli(3,3,0:mrve),xcello(3,3,0:mrve)
      common xi(8,8,0:mrve),xi_old(2,0:mlist2,0:mrve)
      common xmove(mdim1,mp,0:mrve),xNode(0:mrve,3),xRock(3,0:mRock)
      common xRVE(0:mrve),xSat(mLayer)
      common y2_1Rock(mRock+1),y2_2Rock(mRock+1),y2_3Rock(mRock+1)
      common yi(8,8,0:mrve)
c
c Double precision variables:
      common A_1(0:mrve),adtm(0:mrve),alpha_d
      common ambtmp(0:mrve),athdtm(0:mrve),avasp(0:mrve)
      common BaseDepth,beta(0:mrve),betar(0:mrve),boltzman
      common C_11nu(0:mrve),C_factor,cenrad(0:mrve),centrifuge
      common chi1(0:mrve),chi1t(0:mrve),chia1(0:mrve)
      common chi2(0:mrve),chi2t(0:mrve)
      common chi3(0:mrve),chi3t(0:mrve),chi4(0:mrve),chi4t(0:mrve)
      common chiavg(0:mrve),chiavt,chidat(0:mrve),chimax(0:mrve)
      common cirrad(0:mrve)
      common Cn(0:mrve),Cn_1(0:mrve)
      common D_o(0:mrve)
      common dampc1(0:mrve),dampc2(0:mrve),damp1(0:mrve),damp2(0:mrve)
      common dbegin(0:mrve),ddef_target,defw(0:mrve),defwold(0:mrve)
      common dele(0:mrve),dely,delz,DepthNode(0:mrve),DepthRVE(0:mrve)
      common dfunc6,dfunc7,dfunc7i,Dip_soil,Dip_water
      common Direct_soil,Direct_water,Dlast(0:mrve)
      common doubl2,dpfluid(0:mrve),dsfm
      common dslide(0:mrve),dslidet(0:mrve)
      common dt(0:mrve),dtRock,dtinp(0:mrve),dtreal(0:mrve)
      common dtrl2,dtrl2s,dtrlo(0:mrve)
      common dvctrl(0:mrve),dx_rve,dxym(0:mrve)
c
      common Ebar(0:mrve),Ebar23n(0:mrve),Ebar43n(0:mrve)
      common eps_grad,epsd,etargt(0:mrve)
      common fbalsq(0:mrve),fdampa(0:mrve),fk2(0:mrve)
      common fnavg(0:mrve),fnavg2(0:mrve),fpnrgy(0:mrve)
      common frict(0:mrve),frict_sav(0:mrve)
      common frictm(0:mrve),frictw(0:mrve),frict2(0:mrve),ftsq(0:mrve)
      common G(0:mrve),gamm(0:mrve),gamma1,gmod(0:mrve),Gbar(0:mrve)
      common grav
      common h_rho(0:mrve),Hcc(0:mrve),Iavg(0:mrve),Imean(0:mrve)
      common k_a(mLayer),K_f(0:mrve),k_geot(mLayer)
      common K_s(0:mrve),k_w(mLayer)
      common kappa(0:mrve),kbulk(0:mrve)
      common kmdat(0:mrve),kmean(0:mrve)
      common kn(0:mrve),knh(0:mrve),knmax(0:mrve)
      common knrgy(0:mrve),knrgyo(0:mrve)
      common knsep2(0:mrve),knseph(0:mrve)
      common kratio(0:mrve),Ks(mLayer)
      common kt(0:mrve),kth(0:mrve),kthh(0:mrve),Kw
      common lambda(0:mrve),LayerBottom(0:mrve),LayerThickness(mLayer)
      common lPorosity(mLayer),lvoidno(mLayer)
      common massav(0:mrve),massd(0:mrve),massdat(0:mrve),massit(0:mrve)
      common mntav(0:mrve),mntit(0:mrve)
      common N_o(0:mrve),n1(0:mrve),nu(0:mrve)
      common ovravg(0:mrve),ovravgz(0:mrve),ovrdat(0:mrve)
      common ovrsav(0:mrve),ovrsavz(0:mrve)
      common p_atm(0:mrve),p_o(0:mrve),p_vap(0:mrve),p_wcav(0:mrve)
      common palpha(0:mrve)
      common pdat(0:mrve),pdif(0:mrve),pdifsv(0:mrve),pdif2(0:mrve)
      common pfluid(0:mrve),pfluido(0:mrve)
      common pi,picpt1(0:mrve),picpt2(0:mrve),pinit,planck
      common pn(0:mrve),pnrgy(0:mrve)
      common pnrgy1(0:mrve)
      common pnrgy2(0:mrve),pnrgy2o(0:mrve),pnrgy2o_alt(0:mrve)
      common poros0(0:mrve),porosn(0:mrve)
      common powerm,psep1(0:mrve),psep2(0:mrve),psi(0:mrve),ptol(0:mrve)
c
      common ravg(0:mrve),rdampa(0:mrve)
      common rfact1(0:mrve),rfact2(0:mrve),rgas
      common rho(0:mrve),rho_a,rho_dry(mLayer),rho_sat(mLayer),rho_w
      common rhoinp(0:mrve),rin(0:mrve)
      common rmax(0:mrve),rmax2(0:mrve),rmin(0:mrve)
      common rmsvel(0:mrve),rout(0:mrve),rpcmin(0:mrve)
      common S_now(0:mrve),S_o(0:mrve),satrad(0:mrve)
      common sep(0:mrve),seprat0(0:mrve)
      common slidet(0:mrve),slidet_alt(0:mrve)
      common Slope_1,Slope_2,solidr(0:mrve)
      common spheat(0:mrve),spin,spnrgy(0:mrve),srint(0:mrve)
      common stravg(0:mrve),strwold(0:mrve)
      common sweep(0:mrve)
      common t_PostShake, t_Setl
      common tclock(0:mrve),tclokm(0:mrve),tdampa(0:mrve),tdepf(0:mrve)
      common temprt(0:mrve),tfact1(0:mrve),tfact2(0:mrve),thblsq(0:mrve)
      common timer(0:mrve),tmax(0:mrve),tolQ,treal(0:mrve),treal1
c
      common vcell(0:mrve),vcelli(0:mrve)
      common vcell0(0:mrve),vcello(0:mrve),vcellt(0:mrve)
      common visc_a,visc_w,viscbt(0:mrve),viscct(0:mrve)
      common voidn(0:mrve),voidno(0:mrve)
      common volavg(0:mrve),volmin(0:mrve),VolumQ(0:mrve)
      common vs(0:mrve),vso(0:mrve)
      common WaterDepth,work1t(0:mrve),work2t,workc(0:mrve)
      common xLayerBottom(0:mrve),xpnts(0:mrve),xseed(0:mrve),xWater
c
c Character variables:
      common title(0:mrve)
      common cstep(0:mrve),cVar
      common file1(0:mrve),file2(0:mrve),file3(0:mrve)
      common MainDir,partyp(0:mrve),RockMotionFile
      common apend(0:mrve),version
      common RunFileLayer(mLayer),RunFilePath(0:mrve)
      common StartFileLayer(mLayer),StartFilePath(0:mrve)
c
c Logical variables (4 bytes):
      common l3d,lABfile,lanch(0:mrve),lApprox(0:mrve),laxsym(0:mrve)
      common lbody(2,0:mrve),lbodyf,lbumpy(0:mrve)
      common lcdamp(0:mrve)
      common lcircl(0:mrve),lcirc1(0:mrve),lcirc2(0:mrve),lcirc3(0:mrve)
      common lcirct(0:mrve),lconvx(0:mrve)
      common ldat(0:mrve),ldefrm,ldirec(mplatn),ldrain(0:mrve)
      common lelips(0:mrve),lexact
      common lFindModuli,lflag1(0:mrve),lfrict(0:mrve),lgrav(0:mrve)
      common lHertz(0:mrve),lhiddn(0:mrve),linit(0:mrve)
      common linitc(0:mrve),linitf(0:mrve),liso(0:mrve),liso2(0:mrve)
      common lJager(0:mrve),lJagr2(0:mrve),lJagr3(0:mrve),lJagr4(0:mrve)
      common llast(0:mrve)
      common lmove(0:mrve),lnew(0:mrve),lnewc(0:mrve),lnewdt(0:mrve)
      common lnobby(0:mrve)
      common lout(mfiles),loval(0:mrve),lovoid(0:mrve),lovrid
      common lplatn,lplold(0:mlist2,0:mrve),lplotd(0:mrve),lporo(0:mrve)
      common lqcntr(0:mrve),lquez(0:mrve)
      common lreprt(0:mrve),lreset(0:mrve),lrotat(0:mrve)
      common lScreen
      common lsinh(0:mrve),lspher(0:mrve),lsphr(0:mrve)
c     common lstratn
      common ltheta(0:mrve),lthfix(3,0:mplatn,0:mrve)
      common ltotal(8,0:mrve),ltrick
      common lupdat(0:mrve),lvctrl(0:mrve),lwalls
      common lxiold(0:mrve)
c
c Integer variables (4 bytes):
      common box(0:mbox1-1, 0:mbox2-1, 0:mbox3-1,0:mrve)
      common boxi(mboxes,3,0:mrve)
      common f1(0:mlist2,0:mrve),f2(0:mlist2,0:mrve)
      common hole(mholes)
      common hf(mcells,0:mrve),hv(mp,0:mrve)
      common icontl(0:mrve)
      common icontp(0:lc1,0:mrve),icontpl(0:mrve)
      common icontr(0:lc1,0:mrve),icornw(0:3)
      common ihole(0:mrve)
      common iptbx1(1:mbx,0:mrve),iptbx2(1:mbx,0:mrve)
      common istep(0:mrve),istep2(0:mrve),istepa(0:mrve),istepm(0:mrve)
      common isub,itime(0:mrve),itrack(4,0:mrve)
      common lfaces(0:mrve)
      common list1(mfirst+1:mlist,0:mrve),list2(0:mlist,0:mrve)
      common listb(mfirst+1:mlist,0:mrve)
      common liste(0:mlist2,0:mrve),listf0(0:mlist2,0:mrve)
      common loopst(0:mrve)
      common medges(0:mrve),mvers
      common nTiltEquil,nTiltSteps
      common p1(0:mlist2,0:mrve),p2(0:mlist2,0:mrve)
      common v1(0:mlist2,0:mrve),v2(0:mlist2,0:mrve)
      common iouti(0:mrve)
      common ipoint(0:mrve),ipt2,ipt4(0:mrve),merror
      common nbox(3,0:mrve),nboxes(0:mrve)
      common ncells(0:mrve),ncownt,ndim1,ndim2,nerror(0:mrve)
      common nfilled(0:mrve)
      common nnear(0:mrve),np(0:mrve),np2,npiece(0:mrve)
      common nRock,nRockalt,nslide(0:mrve),nsteps_min
      common ntacts(0:mrve),ntactz(0:mrve)
      common nupdat4(0:mrve),nverts(0:mrve)
c
c Integer arrays (2 bytes):
c
      common AUnit(0:mrve),BUnit(0:mrve),countr(8,0:mrve)
      common ErrUnit(0:mrve)
      common ianch(3,0:mrve),nbound(3)
      common icont(7,0:mrve),idump(0:lc1,0:mrve),iflexc(0:lc1)
      common ifrctnl(0:mrve)
      common ifn_togl(0:mlist2,0:mrve),igoal(0:lc1,0:mrve)
      common iiso(3,0:mrve)
      common iknown(8,0:mrve),imicro(0:lc1,0:mrve),iout(10)
      common ip1cnt(8,0:mrve),ip2cnt(8,0:mrve)
      common iplot(0:lc1,0:mrve),ipts2(0:lc1,0:mrve),ipts(0:lc1,0:mrve)
      common islip(0:mlist2,0:mrve), isolve(8,0:mrve)
      common jCap(0:mrve)
      common Isotropic(mLayer)
      common ivctrl(8,0:mrve),ivers(0:mrve)
      common krotat(0:lc1,0:mrve)
      common LayerRVE(0:mrve)
      common list3(mfirst+1:mlist,-1:mlist3,0:mrve)
      common listf1(0:mlist2,0:mrve),listf2(0:mlist2,0:mrve)
      common nabors(mp,0:mrve),nbumps(0:mrve),nsepf(0:ldiams)
      common nslidc(mp,0:mrve)
      common quad(2,0:mlist2,0:mrve),ScrUnit(0:mrve)
c
c Integer variables (2 bytes):
      common algori,botrve,Bversn,hmodel(0:mrve)
      common iABfile,iCap(mLayer),icirct,icoef,idamp(0:mrve)
      common idumpi(0:mrve)
      common idef(0:mrve),iend(0:mrve),iexact,iflex
      common igoala(0:mrve),igoalb(0:mrve),iheat(0:mrve)
      common iloops,ilpavg,imodel(0:mrve)
      common ioutd,iqcntr(0:mrve),iporo(0:mrve), iPreProcess
      common iRunLayer_DEM(0:mrve),iRunRVE_DEM(0:mrve)
      common iRunRVEModuli(0:mrve)
      common ischeme,ishrtn(0:mrve)
      common istart(0:mrve),iSystem
      common itxt(0:mrve),iupdat(0:mrve),iupdtm(0:mrve)
      common kshape(0:mrve)
      common lpsxcd(0:mrve),lSat(mLayer),lvers(mLayer)
      common ndat(0:mrve),nDEM_out,nDempla_out,ndiams(0:mrve)
      common nfacts(0:mrve),nfit,niso(0:mrve),njoin(0:mrve)
      common nknown(0:mrve)
      common nloop1,nloop2,nLayers,nloops
      common nlpmin,nobs(0:mrve),npnts_xtra
      common np1(0:mrve),npiecs(0:mrve)
      common nsolve(0:mrve),nsplin
c     common number
      common nupdat(0:mrve),nRVEs
      common topdif
c
