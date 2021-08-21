      program assembly
c
c This program take a single 'D*' or 'E*' file and creates another 'D*'  or
c 'E*' file by combining an integer number assemblies of the first file.
c
      implicit integer*2 (i-n)
      implicit double precision(a-h,o-z)
      double precision rad,x,xdup,xcell,deform,deform1,deform2
      character*80 file1,file2
      integer*2 dup,dup2,kshape
      integer*4 nballs,np
c
      character*1 expand
c
      dimension dup(3),dup2(3),x(3),xdup(3),xcell(3,3)
c
      nballs = 1
c
      print *,' Name of the input file: '
      read(*,900) file1
  900 format(a80)
c
      print *,' Type of input file:'
      print *,'   1) Formatted (D-type)'
      print *,'   2) Unformatted (E-type)'
      read *,itype1
c
      print *,' Name of the output file: '
      read(*,900) file2
c
      print *,' Type of output file:'
      print *,'   1) Formatted (D-type)'
      print *,'   2) Unformatted (E-type)'
      read *,itype2
c
      print *,' Integer number of duplications in x-direction:'
      read *,dup(1)
c
      print *,' Integer number of duplications in y-direction:'
      read *,dup(2)
c
      dup(3) = 1.d0
c
      print *,' Do you want to isotropically dilate the specimen? (y/n)'
      read *,expand
c
      if(expand.eq.'y') then
        print *,' Give the x-dilation ratio (no dilatation = 1.00):'
        read *,deform1
        print *,' Give the y-dilation ratio (no dilatation = 1.00):'
        read *,deform2
c       deform2 = deform1*
c    x          2.98994563276730430D+01/2.98446889993219070D+01
        print *,deform1,deform2
      else
        deform1 = 1.d0
        deform2 = 1.d0
      endif
c
      if(itype1.eq.1) then
        open(unit=1,file=file1)
      elseif(itype1.eq.2) then
        open(unit=1,file=file1,form='unformatted')
      endif
c
      if(itype2.eq.1) then
        open(unit=2,file=file2)
      elseif(itype2.eq.2) then
        open(unit=2,file=file2,form='unformatted')
      endif
c
      if(itype1.eq.1) then
        read(1,300) kshape
        read(1,301) np,(xcell(i,i),i=1,3)
        read(1,303) xcell(1,2),xcell(1,3),xcell(2,3)
      elseif(itype1.eq.2) then
        read(1) kshape
        read(1) np,(xcell(i,i),i=1,3)
        read(1) xcell(1,2),xcell(1,3),xcell(2,3)
      endif
c
      nballs = 1
      nballs = nballs*np*dup(1)*dup(2)
c
      if(expand.eq.'n') then
        if(itype2.eq.1) then
          write(2,300) kshape
          write(2,301) nballs,
     x                 (xcell(i,i)*dup(i),i=1,3)
          write(2,303) xcell(1,2)*dup(2),xcell(1,3)*dup(3),
     x                 xcell(2,3)*dup(3)
        elseif(itype2.eq.2) then
          write(2)     kshape
          write(2)     nballs,
     x                 (xcell(i,i)*dup(i),i=1,3)
          write(2)     xcell(1,2)*dup(2),xcell(1,3)*dup(3),
     x                 xcell(2,3)*dup(3)
        endif
      elseif(expand.eq.'y') then
        if(itype2.eq.1) then
          write(2,300) kshape
          write(2,301) nballs,
     x                 xcell(1,1)*dup(1)*deform1,
     x                 xcell(2,2)*dup(2)*deform2,
     x                 xcell(3,3)
          write(2,303) xcell(1,2)*dup(2),
     x                 xcell(1,3),
     x                 xcell(2,3)
        elseif(itype2.eq.2) then
          write(2)     kshape
          write(2)     nballs,
     x                 xcell(1,1)*dup(1)*deform1,
     x                 xcell(2,2)*dup(2)*deform2,
     x                 xcell(3,3)
          write(2)     xcell(1,2)*dup(2),
     x                 xcell(1,3),
     x                 xcell(2,3)
        endif
      endif
c
      istato = 0
c
      do 20 i = 1,np
        if(itype1.eq.1) then
          read(1,302) rad,(x(ii),ii=1,2)
        elseif(itype1.eq.2) then
          read(1) rad,(x(ii),ii=1,2)
        endif
c
        l = 1
        do 30 j = 0,dup(1)-1
          dup2(1) = j
          do 40 k = 0,dup(2)-1
            dup2(2) = k
c
            do 60 m = 1,2
              xdup(m) = x(m)
              do 70 n = 1,2
                xdup(m) = xdup(m) + xcell(m,n)*dup2(n)
   70         continue
   60       continue
c
            if(expand.eq.'n') then
              if(itype2.eq.1) then
                write(2,302) rad,(xdup(ii),ii=1,2)
              else
                write(2)     rad,(xdup(ii),ii=1,2)
              endif
            elseif(expand.eq.'y') then
              if(itype2.eq.1) then
                write(2,302) rad,xdup(1)*deform1,xdup(2)*deform2
              else
                write(2)     rad,xdup(1)*deform1,xdup(2)*deform2
              endif
            endif
c
   40     continue
   30   continue
        istat = i/20
        if(istat.gt.istato) then
          istato = istat
          print *,istat*20
        endif
   20 continue
c
      close(unit=1)
      close(unit=2)
c
  300 format(i1)
  301 format(i6,3(1pe25.17))
  303 format(6x,3(1pe25.17))
  302 format(4(1pe25.17))
c
      end
