function [Shape, np, init_e, ...
      Time, Def11, Def22, Def33, Def12, Def13, Def23, ...
      Stress11, Stress22, Stress33, Stress12, Stress13, Stress23, ...
      Chi1, Chi2, Psi, ntacts, ...
      Fab1_11, Fab1_22, Fab1_33, Fab1_12, Fab1_13, Fab1_23, ...
      Fab2_11, Fab2_22, Fab2_33, Fab2_12, Fab2_13, Fab2_23, ...
      Vfab, eRatio, e_eff, Lfaces, Medges, Nverts, ...
      Knrgy, Pnrgy, Slidet, Viscbt, Viscct, Work1t, ...
      Nslide, Nnear, Solidr, ...
      StressSub11, StressSub22, StressSub33, ...
      StressSub12, StressSub13, StressSub23, ...
      FabSub11, FabSub22, FabSub33, ...
      FabSub12, FabSub13, FabSub23, NtacsSub, Octavg, Octav2, Tempr, ...
      ntactz, ...
      pfluid, defw, fpnrgy, spnrgy, S_now] = ...
  Read_A_file6(A_file_name, Shape, IgnoreLines);
%
% |+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|
%
% This function reads an OVAL or DEMPLA A-file and returns arrays
% with varous A-file output. The function call is given below.  The
% input arguments are as follows:
%   A_file_name   the character string of the full file name, including
%                 the full path of the file and the '.txt' extension
%   Shape         integer iShape of the particle shape
%   IgnoreLines   integer 0
%
% Dependencies:  requires the Shapes3 function
%
% Function call...
% 
% [Shape, np, init_e, ...
%       Time, Def11, Def22, Def33, Def12, Def13, Def23, ...
%       Stress11, Stress22, Stress33, Stress12, Stress13, Stress23, ...
%       Chi1, Chi2, Psi, ntacts, ...
%       Fab1_11, Fab1_22, Fab1_33, Fab1_12, Fab1_13, Fab1_23, ...
%       Fab2_11, Fab2_22, Fab2_33, Fab2_12, Fab2_13, Fab2_23, ...
%       Vfab, eRatio, e_eff, Lfaces, Medges, Nverts, ...
%       Knrgy, Pnrgy, Slidet, Viscbt, Viscct, Work1t, ...
%       Nslide, Nnear, Solidr, ...
%       StressSub11, StressSub22, StressSub33, ...
%       StressSub12, StressSub13, StressSub23, ...
%       FabSub11, FabSub22, FabSub33, ...
%       FabSub12, FabSub13, FabSub23, NtacsSub, Octavg, Octav2, Tempr, ...
%       ntactz, ...
%       pfluid, defw, fpnrgy, spnrgy, S_now] = ...
%   Read_A_file6(A_file_name, Shape, IgnoreLines);
%
  BinDirectory = '/home/kuhn/bin/';
  TmpDirectory = '/home/kuhn/tmp/';
%
% Assign integer values to the possible particle shapes FUNCTION Shapes
  [Circle, Oval, Ellipse, Sphere, Ovoid, Nobby, Bumpy] = Shapes3();
%
  A_file_name;
%
  if ~exist(A_file_name, 'file')
    disp('File does not exist for Read_A_file2.m:')
    disp(A_file_name)
  end
%
  Afile = fopen(A_file_name,'rt');
    fgetl(Afile); % Skip the first line
    AFileVersion = fgetl(Afile); % Read file version from 2nd line
    if length(AFileVersion) == 0
%-----older files have not File Version
      AFileVersion = 0;
    else
%-----File Version from newer files (post oval 0.6.92 or thereabout)
      AFileVersion = str2num(AFileVersion);
    end
%
%---Grab the third line from the file
    OvalVersionLine = fgetl(Afile);
%
%---Test whether this 3rd line contains a "tab" characher.  If not, it was
%   created by an older version of OVAL that was compiled with the g77
%   compiler, and we must insert the tabs.  To insert tabs, we can
%   run the script file "Afile_add_tabs"
    Skip_these_lines = 1;
    if ~Skip_these_lines
      if isempty(strfind(OvalVersionLine, '\t'))
%-------find and run the script file, and place the corrected version in
%       the "tmp" directory
        TmpA_file_Name = strcat(TmpDirectory,  'AtmpOctave.txt');
        add_tabs_script = strcat(BinDirectory, 'Afile_add_tabs');
        Shell_command = strcat(add_tabs_script, ' ', A_file_name, ' ', ...
                               TmpA_file_Name);
        system(Shell_command);
%
%-------now we have corrected the file.  Get back to the third line
        fclose(Afile);
        Afile = fopen(TmpA_file_Name,'r');
        fgetl(Afile); % Skip the first line
        fgetl(Afile); % Skip the second line
        OvalVersionLine = fgetl(Afile);
      end
    end
%
%---read the fourth line, containing particle shape
    ShapeLine = fgetl(Afile);  % The fourth line, containing particle shape
    if ~isempty(findstr(ShapeLine, 'Circ'))
      Shape = Circle;
    elseif ~isempty(findstr(ShapeLine, 'oval'))
      Shape = Oval;
    elseif ~isempty(findstr(ShapeLine, 'Ellip'))
      Shape = Ellipse;
    elseif ~isempty(findstr(ShapeLine, 'Spher'))
      Shape = Sphere;
    elseif ~isempty(findstr(ShapeLine, 'ovoid'))
      Shape = Ovoid;
    elseif ~isempty(findstr(ShapeLine, 'nobb'))
      Shape = Nobby;
    elseif ~isempty(findstr(ShapeLine, 'bumpy'))
      Shape = Bumpy;
    end
%
    if Shape==Circle || Shape==Oval || Shape==Ellipse || Shape==Nobby
      ndim = 2;
    elseif Shape==Sphere || Shape==Ovoid || Shape==Bumpy
      ndim = 3;
    end
%
%---read the fifth line, containing number of particles
    npLine = fgetl(Afile);
    np = str2num(npLine(end-6:end));
    if isempty(np)
      np = str2num(npLine(end-5:end));
    end
%
%---read the sixth line, containing the initial void ratio
    eLine = fgetl(Afile);
    init_e = str2num(eLine(end-9:end));
%
%---Skip the next four lines
    fgetl(Afile); fgetl(Afile); fgetl(Afile); fgetl(Afile);
%
%---Skip more lines if "IgnoreLines" > 0
    for i = 1:IgnoreLines
      fgetl(Afile);
    end
%
%---Initialize these variable so that they have an assigned value
    Viscbt=0; Viscct=0; Work1t=0; Def13=0; Def23=0; Def33=0; 
    Stress13=0; Stress23=0; Stress33=0;
    Fab1_13=0; Fab1_23=0; Fab1_33=0; Fab2_13=0; Fab2_23=0; Fab2_33=0;
    StressSub11=0; StressSub22=0; StressSub33=0; 
    StressSub12=0; StressSub13=0; StressSub23=0;
    FabSub11=0; FabSub22=0; FabSub33=0; 
    FabSub12=0; FabSub13=0; FabSub23=0; NtacsSub=0; Octavg=0; Octav2=0;
    Lfaces=0; Medges=0; Nverts=0; Tempr=0; ntactz = 0;
%
    pfluid = [];
    defw =   [];
    fpnrgy = [];
    spnrgy = [];
    S_now =  [];
%
%---NOTE:  function 'TabTemplate' is at the bottom of this file
    if (AFileVersion==0 & ndim==2) ...
       || (AFileVersion==100 || AFileVersion==101) ...
       || (AFileVersion==130 || AFileVersion==131) ...
       || (AFileVersion==140 || AFileVersion==141)
%
      if AFileVersion==130 || AFileVersion==131
        nFields = 36;
      elseif AFileVersion==140 || AFileVersion==141
        nFields = 37;
      else
        nFields = 32;
      end
%
      TEMPLATE = TabTemplate(nFields);
%
      [AData, Count] = fscanf(Afile, TEMPLATE);
      Time =     AData( 1:nFields:Count);
      Def11 =    AData( 2:nFields:Count);
      Def22 =    AData( 3:nFields:Count);
      Def12 =    AData( 4:nFields:Count);
      Stress11 = AData( 5:nFields:Count);
      Stress22 = AData( 6:nFields:Count);
      Stress12 = AData( 7:nFields:Count);
      Chi1     = AData( 8:nFields:Count);
      Chi2     = AData( 9:nFields:Count);
      Psi      = AData(10:nFields:Count);
      ntacts   = AData(11:nFields:Count);
      Fab1_11  = AData(12:nFields:Count);
      Fab1_12  = AData(13:nFields:Count);
      Fab1_22  = AData(14:nFields:Count);
      Fab2_11  = AData(15:nFields:Count);
      Fab2_12  = AData(16:nFields:Count);
      Fab2_22  = AData(17:nFields:Count);
      Vfab     = AData(18:nFields:Count);
      Lfaces   = AData(19:nFields:Count);
      Medges   = AData(20:nFields:Count);
      Nverts   = AData(21:nFields:Count);
      eRatio   = AData(22:nFields:Count);
      e_eff    = AData(23:nFields:Count);
      Knrgy    = AData(24:nFields:Count);
      Pnrgy    = AData(25:nFields:Count);
      Slidet   = AData(26:nFields:Count);
      Viscbt   = AData(27:nFields:Count);
      Viscct   = AData(28:nFields:Count);
      Work1t   = AData(29:nFields:Count);
      Nslide   = AData(30:nFields:Count);
      Nnear    = AData(31:nFields:Count);
      Solidr   = AData(32:nFields:Count);
%
      if AFileVersion==130 || AFileVersion==131
        pfluid = AData(33:nFields:Count); 
        defw =   AData(34:nFields:Count);
        fpnrgy = AData(35:nFields:Count);
        spnrgy = AData(36:nFields:Count);
      elseif AFileVersion==140 || AFileVersion==141
        pfluid = AData(33:nFields:Count);
        defw =   AData(34:nFields:Count);
        fpnrgy = AData(35:nFields:Count);
        spnrgy = AData(36:nFields:Count);
        S_now =  AData(37:nFields:Count);
      end
%
    elseif    AFileVersion==102 || AFileVersion==103 ...
           || AFileVersion==132 || AFileVersion==133
%
      if AFileVersion==132 || AFileVersion==133
        nFields = 37;
      elseif AFileVersion==142 || AFileVersion==143
        nFields = 38;
      else
        nFields = 33;
      end
%
      TEMPLATE = TabTemplate(nFields);
%
      [AData, Count] = fscanf(Afile, TEMPLATE);
      Time =     AData( 1:nFields:Count);
      Def11 =    AData( 2:nFields:Count);
      Def22 =    AData( 3:nFields:Count);
      Def12 =    AData( 4:nFields:Count);
      Stress11 = AData( 5:nFields:Count);
      Stress22 = AData( 6:nFields:Count);
      Stress12 = AData( 7:nFields:Count);
      Chi1     = AData( 8:nFields:Count);
      Chi2     = AData( 9:nFields:Count);
      Psi      = AData(10:nFields:Count);
      ntacts   = AData(11:nFields:Count);
      Fab1_11  = AData(12:nFields:Count);
      Fab1_12  = AData(13:nFields:Count);
      Fab1_22  = AData(14:nFields:Count);
      Fab2_11  = AData(15:nFields:Count);
      Fab2_12  = AData(16:nFields:Count);
      Fab2_22  = AData(17:nFields:Count);
      Vfab     = AData(18:nFields:Count);
      Lfaces   = AData(19:nFields:Count);
      Medges   = AData(20:nFields:Count);
      Nverts   = AData(21:nFields:Count);
      eRatio   = AData(22:nFields:Count);
      e_eff    = AData(23:nFields:Count);
      Knrgy    = AData(24:nFields:Count);
      Pnrgy    = AData(25:nFields:Count);
      Slidet   = AData(26:nFields:Count);
      Viscbt   = AData(27:nFields:Count);
      Viscct   = AData(28:nFields:Count);
      Work1t   = AData(29:nFields:Count);
      Nslide   = AData(30:nFields:Count);
      Nnear    = AData(31:nFields:Count);
      Solidr   = AData(32:nFields:Count);
      ntactz   = AData(33:nFields:Count);
%
      if AFileVersion==132 || AFileVersion==133
        pfluid = AData(34:nFields:Count);
        defw =   AData(35:nFields:Count);
        fpnrgy = AData(36:nFields:Count);
        spnrgy = AData(37:nFields:Count);
      elseif AFileVersion==142 || AFileVersion==143
        pfluid = AData(34:nFields:Count);
        defw =   AData(35:nFields:Count);
        fpnrgy = AData(36:nFields:Count);
        spnrgy = AData(37:nFields:Count);
        S_now =  AData(38:nFields:Count);
      end
%
    elseif (AFileVersion==0 & ndim==3) ...
           || AFileVersion==110 ||  AFileVersion==140 ...
           || AFileVersion==150
%
      if AFileVersion==140
        nFields = 45;
      elseif AFileVersion==150
        nFields = 46;
      else
        nFields = 41;
      end
%
      TEMPLATE = TabTemplate(nFields);
%
      [AData, Count] = fscanf(Afile, TEMPLATE);
      Time =     AData( 1:nFields:Count);
      Def11 =    AData( 2:nFields:Count);
      Def22 =    AData( 3:nFields:Count);
      Def33 =    AData( 4:nFields:Count);
      Def12 =    AData( 5:nFields:Count);
      Def13 =    AData( 6:nFields:Count);
      Def23 =    AData( 7:nFields:Count);
      Stress11 = AData( 8:nFields:Count);
      Stress22 = AData( 9:nFields:Count);
      Stress33 = AData(10:nFields:Count);
      Stress12 = AData(11:nFields:Count);
      Stress13 = AData(12:nFields:Count);
      Stress23 = AData(13:nFields:Count);
      Chi1     = AData(14:nFields:Count);
      Chi2     = AData(15:nFields:Count);
      Psi      = AData(16:nFields:Count);
      ntacts   = AData(17:nFields:Count);
      Fab1_11  = AData(18:nFields:Count);
      Fab1_22  = AData(19:nFields:Count);
      Fab1_33  = AData(20:nFields:Count);
      Fab1_12  = AData(21:nFields:Count);
      Fab1_13  = AData(22:nFields:Count);
      Fab1_23  = AData(23:nFields:Count);
      Fab2_11  = AData(24:nFields:Count);
      Fab2_22  = AData(25:nFields:Count);
      Fab2_33  = AData(26:nFields:Count);
      Fab2_12  = AData(27:nFields:Count);
      Fab2_13  = AData(28:nFields:Count);
      Fab2_23  = AData(29:nFields:Count);
      Vfab     = AData(30:nFields:Count);
      eRatio   = AData(31:nFields:Count);
      e_eff    = AData(32:nFields:Count);
      Knrgy    = AData(33:nFields:Count);
      Pnrgy    = AData(34:nFields:Count);
      Slidet   = AData(35:nFields:Count);
      Viscbt   = AData(36:nFields:Count);
      Viscct   = AData(37:nFields:Count);
      Work1t   = AData(38:nFields:Count);
      Nslide   = AData(39:nFields:Count);
      Nnear    = AData(40:nFields:Count);
      Solidr   = AData(41:nFields:Count);
%
      if AFileVersion==140
        pfluid = AData(42:nFields:Count);
        defw =   AData(43:nFields:Count);
        fpnrgy = AData(44:nFields:Count);
        spnrgy = AData(45:nFields:Count);
      elseif AFileVersion==150
        pfluid = AData(42:nFields:Count);
        defw =   AData(43:nFields:Count);
        fpnrgy = AData(44:nFields:Count);
        spnrgy = AData(45:nFields:Count);
        S_now =  AData(46:nFields:Count);
      end
%
    elseif AFileVersion==112 || AFileVersion==142 || AFileVersion==152
%
      if AFileVersion==142
        nFields = 47;
      elseif AFileVersion==152
        nFields = 47;
      else
        nFields = 42;
      end
%
      TEMPLATE = TabTemplate(nFields);
%
      [AData, Count] = fscanf(Afile, TEMPLATE);
      Time =     AData( 1:nFields:Count);
      Def11 =    AData( 2:nFields:Count);
      Def22 =    AData( 3:nFields:Count);
      Def33 =    AData( 4:nFields:Count);
      Def12 =    AData( 5:nFields:Count);
      Def13 =    AData( 6:nFields:Count);
      Def23 =    AData( 7:nFields:Count);
      Stress11 = AData( 8:nFields:Count);
      Stress22 = AData( 9:nFields:Count);
      Stress33 = AData(10:nFields:Count);
      Stress12 = AData(11:nFields:Count);
      Stress13 = AData(12:nFields:Count);
      Stress23 = AData(13:nFields:Count);
      Chi1     = AData(14:nFields:Count);
      Chi2     = AData(15:nFields:Count);
      Psi      = AData(16:nFields:Count);
      ntacts   = AData(17:nFields:Count);
      Fab1_11  = AData(18:nFields:Count);
      Fab1_22  = AData(19:nFields:Count);
      Fab1_33  = AData(20:nFields:Count);
      Fab1_12  = AData(21:nFields:Count);
      Fab1_13  = AData(22:nFields:Count);
      Fab1_23  = AData(23:nFields:Count);
      Fab2_11  = AData(24:nFields:Count);
      Fab2_22  = AData(25:nFields:Count);
      Fab2_33  = AData(26:nFields:Count);
      Fab2_12  = AData(27:nFields:Count);
      Fab2_13  = AData(28:nFields:Count);
      Fab2_23  = AData(29:nFields:Count);
      Vfab     = AData(30:nFields:Count);
      eRatio   = AData(31:nFields:Count);
      e_eff    = AData(32:nFields:Count);
      Knrgy    = AData(33:nFields:Count);
      Pnrgy    = AData(34:nFields:Count);
      Slidet   = AData(35:nFields:Count);
      Viscbt   = AData(36:nFields:Count);
      Viscct   = AData(37:nFields:Count);
      Work1t   = AData(38:nFields:Count);
      Nslide   = AData(39:nFields:Count);
      Nnear    = AData(40:nFields:Count);
      Solidr   = AData(41:nFields:Count);
      ntactz   = AData(42:nFields:Count);
%
      if AFileVersion==142
        pfluid = AData(43:nFields:Count);
        defw =   AData(44:nFields:Count);
        fpnrgy = AData(45:nFields:Count);
        spnrgy = AData(46:nFields:Count);
      elseif AFileVersion==152
        pfluid = AData(43:nFields:Count);
        defw =   AData(44:nFields:Count);
        fpnrgy = AData(45:nFields:Count);
        spnrgy = AData(46:nFields:Count);
        S_now =  AData(47:nFields:Count);
      end
%
    elseif AFileVersion==111 || AFileVersion==141 || AFileVersion==151
%
      if AFileVersion==141
        nFields = 46;
      elseif AFileVersion==151
        nFields = 47;
      else
        nFields = 42;
      end
%
      TEMPLATE = TabTemplate(nFields);
      [AData, Count] = fscanf(Afile, TEMPLATE);
      Time =     AData( 1:nFields:Count);
      Def11 =    AData( 2:nFields:Count);
      Def22 =    AData( 3:nFields:Count);
      Def33 =    AData( 4:nFields:Count);
      Def12 =    AData( 5:nFields:Count);
      Def13 =    AData( 6:nFields:Count);
      Def23 =    AData( 7:nFields:Count);
      Stress11 = AData( 8:nFields:Count);
      Stress22 = AData( 9:nFields:Count);
      Stress33 = AData(10:nFields:Count);
      Stress12 = AData(11:nFields:Count);
      Stress13 = AData(12:nFields:Count);
      Stress23 = AData(13:nFields:Count);
      Chi1     = AData(14:nFields:Count);
      Chi2     = AData(15:nFields:Count);
      Psi      = AData(16:nFields:Count);
      ntacts   = AData(17:nFields:Count);
      Fab1_11  = AData(18:nFields:Count);
      Fab1_22  = AData(19:nFields:Count);
      Fab1_33  = AData(20:nFields:Count);
      Fab1_12  = AData(21:nFields:Count);
      Fab1_13  = AData(22:nFields:Count);
      Fab1_23  = AData(23:nFields:Count);
      Fab2_11  = AData(24:nFields:Count);
      Fab2_22  = AData(25:nFields:Count);
      Fab2_33  = AData(26:nFields:Count);
      Fab2_12  = AData(27:nFields:Count);
      Fab2_13  = AData(28:nFields:Count);
      Fab2_23  = AData(29:nFields:Count);
      Vfab     = AData(30:nFields:Count);
      eRatio   = AData(31:nFields:Count);
      e_eff    = AData(32:nFields:Count);
      Knrgy    = AData(33:nFields:Count);
      Pnrgy    = AData(34:nFields:Count);
      Slidet   = AData(35:nFields:Count);
      Viscbt   = AData(36:nFields:Count);
      Viscct   = AData(37:nFields:Count);
      Work1t   = AData(38:nFields:Count);
      Nslide   = AData(39:nFields:Count);
      Nnear    = AData(40:nFields:Count);
      Solidr   = AData(41:nFields:Count);
      Tempr    = AData(42:nFields:Count);
%
      if AFileVersion==141
        pfluid = AData(43:nFields:Count);
        defw =   AData(44:nFields:Count);
        fpnrgy = AData(45:nFields:Count);
        spnrgy = AData(46:nFields:Count);
      elseif AFileVersion==151
        pfluid = AData(43:nFields:Count);
        defw =   AData(44:nFields:Count);
        fpnrgy = AData(45:nFields:Count);
        spnrgy = AData(46:nFields:Count);
        S_now =  AData(47:nFields:Count);
      end
%
    elseif AFileVersion==113 || AFileVersion==143 || AFileVersion==153
%
      if AFileVersion==113
        nFields = 43;
      elseif AFileVersion==143
        nFields = 47;
      elseif AFileVersion==153
        nFields = 48;
      end
%
      TEMPLATE = TabTemplate(nFields);
%
      [AData, Count] = fscanf(Afile, TEMPLATE);
      Time =     AData( 1:nFields:Count);
      Def11 =    AData( 2:nFields:Count);
      Def22 =    AData( 3:nFields:Count);
      Def33 =    AData( 4:nFields:Count);
      Def12 =    AData( 5:nFields:Count);
      Def13 =    AData( 6:nFields:Count);
      Def23 =    AData( 7:nFields:Count);
      Stress11 = AData( 8:nFields:Count);
      Stress22 = AData( 9:nFields:Count);
      Stress33 = AData(10:nFields:Count);
      Stress12 = AData(11:nFields:Count);
      Stress13 = AData(12:nFields:Count);
      Stress23 = AData(13:nFields:Count);
      Chi1     = AData(14:nFields:Count);
      Chi2     = AData(15:nFields:Count);
      Psi      = AData(16:nFields:Count);
      ntacts   = AData(17:nFields:Count);
      Fab1_11  = AData(18:nFields:Count);
      Fab1_22  = AData(19:nFields:Count);
      Fab1_33  = AData(20:nFields:Count);
      Fab1_12  = AData(21:nFields:Count);
      Fab1_13  = AData(22:nFields:Count);
      Fab1_23  = AData(23:nFields:Count);
      Fab2_11  = AData(24:nFields:Count);
      Fab2_22  = AData(25:nFields:Count);
      Fab2_33  = AData(26:nFields:Count);
      Fab2_12  = AData(27:nFields:Count);
      Fab2_13  = AData(28:nFields:Count);
      Fab2_23  = AData(29:nFields:Count);
      Vfab     = AData(30:nFields:Count);
      eRatio   = AData(31:nFields:Count);
      e_eff    = AData(32:nFields:Count);
      Knrgy    = AData(33:nFields:Count);
      Pnrgy    = AData(34:nFields:Count);
      Slidet   = AData(35:nFields:Count);
      Viscbt   = AData(36:nFields:Count);
      Viscct   = AData(37:nFields:Count);
      Work1t   = AData(38:nFields:Count);
      Nslide   = AData(39:nFields:Count);
      Nnear    = AData(40:nFields:Count);
      Solidr   = AData(41:nFields:Count);
      Tempr    = AData(42:nFields:Count);
      ntactz   = AData(43:nFields:Count);
%
      if AFileVersion==143
        pfluid = AData(44:nFields:Count);
        defw =   AData(45:nFields:Count);
        fpnrgy = AData(46:nFields:Count);
        spnrgy = AData(47:nFields:Count);
      elseif AFileVersion==153
        pfluid = AData(44:nFields:Count);
        defw =   AData(45:nFields:Count);
        fpnrgy = AData(46:nFields:Count);
        spnrgy = AData(47:nFields:Count);
        S_now =  AData(48:nFields:Count);
      end
%
    elseif AFileVersion==120 || AFileVersion==150 || AFileVersion==160
      if AFileVersion==120
        nFields = 54;
      elseif AFileVersion==150
        nFields = 58;
      elseif AFileVersion==160
        nFields = 59;
      end
%
      TEMPLATE = TabTemplate(nFields);
%
      [AData, Count] = fscanf(Afile, TEMPLATE);
      Time =     AData( 1:nFields:Count);
      Def11 =    AData( 2:nFields:Count);
      Def22 =    AData( 3:nFields:Count);
      Def33 =    AData( 4:nFields:Count);
      Def12 =    AData( 5:nFields:Count);
      Def13 =    AData( 6:nFields:Count);
      Def23 =    AData( 7:nFields:Count);
      Stress11 = AData( 8:nFields:Count);
      Stress22 = AData( 9:nFields:Count);
      Stress33 = AData(10:nFields:Count);
      Stress12 = AData(11:nFields:Count);
      Stress13 = AData(12:nFields:Count);
      Stress23 = AData(13:nFields:Count);
      Chi1     = AData(14:nFields:Count);
      Chi2     = AData(15:nFields:Count);
      Psi      = AData(16:nFields:Count);
      ntacts   = AData(17:nFields:Count);
      Fab1_11  = AData(18:nFields:Count);
      Fab1_22  = AData(19:nFields:Count);
      Fab1_33  = AData(20:nFields:Count);
      Fab1_12  = AData(21:nFields:Count);
      Fab1_13  = AData(22:nFields:Count);
      Fab1_23  = AData(23:nFields:Count);
      Fab2_11  = AData(24:nFields:Count);
      Fab2_22  = AData(25:nFields:Count);
      Fab2_33  = AData(26:nFields:Count);
      Fab2_12  = AData(27:nFields:Count);
      Fab2_13  = AData(28:nFields:Count);
      Fab2_23  = AData(29:nFields:Count);
      Vfab     = AData(30:nFields:Count);
      eRatio   = AData(31:nFields:Count);
      e_eff    = AData(32:nFields:Count);
      Knrgy    = AData(33:nFields:Count);
      Pnrgy    = AData(34:nFields:Count);
      Slidet   = AData(35:nFields:Count);
      Viscbt   = AData(36:nFields:Count);
      Viscct   = AData(37:nFields:Count);
      Work1t   = AData(38:nFields:Count);
      Nslide   = AData(39:nFields:Count);
      Nnear    = AData(40:nFields:Count);
      Solidr   = AData(41:nFields:Count);
      StressSub11 = AData(42:nFields:Count);
      StressSub22 = AData(43:nFields:Count);
      StressSub33 = AData(44:nFields:Count);
      StressSub12 = AData(45:nFields:Count);
      StressSub13 = AData(46:nFields:Count);
      StressSub23 = AData(47:nFields:Count);
      FabSub11  = AData(48:nFields:Count);
      FabSub22  = AData(49:nFields:Count);
      FabSub33  = AData(50:nFields:Count);
      FabSub12  = AData(51:nFields:Count);
      FabSub13  = AData(52:nFields:Count);
      FabSub23  = AData(53:nFields:Count);
      NtacsSub  = AData(54:nFields:Count);
%
      if AFileVersion==150
        pfluid = AData(55:nFields:Count);
        defw =   AData(56:nFields:Count);
        fpnrgy = AData(57:nFields:Count);
        spnrgy = AData(58:nFields:Count);
      elseif AFileVersion==160
        pfluid = AData(55:nFields:Count);
        defw =   AData(56:nFields:Count);
        fpnrgy = AData(57:nFields:Count);
        spnrgy = AData(58:nFields:Count);
        S_now =  AData(59:nFields:Count);
      end
%
    elseif AFileVersion==121 || AFileVersion==151 || AFileVersion==161
%
      if AFileVersion==121
        nFields = 56;
      elseif AFileVersion==151
        nFields = 60;
      elseif AFileVersion==161
        nFields = 61;
      end
%
      TEMPLATE = TabTemplate(nFields);
      [AData, Count] = fscanf(Afile, TEMPLATE);
      Time =     AData( 1:nFields:Count);
      Def11 =    AData( 2:nFields:Count);
      Def22 =    AData( 3:nFields:Count);
      Def33 =    AData( 4:nFields:Count);
      Def12 =    AData( 5:nFields:Count);
      Def13 =    AData( 6:nFields:Count);
      Def23 =    AData( 7:nFields:Count);
      Stress11 = AData( 8:nFields:Count);
      Stress22 = AData( 9:nFields:Count);
      Stress33 = AData(10:nFields:Count);
      Stress12 = AData(11:nFields:Count);
      Stress13 = AData(12:nFields:Count);
      Stress23 = AData(13:nFields:Count);
      Chi1     = AData(14:nFields:Count);
      Chi2     = AData(15:nFields:Count);
      Psi      = AData(16:nFields:Count);
      ntacts   = AData(17:nFields:Count);
      Fab1_11  = AData(18:nFields:Count);
      Fab1_22  = AData(19:nFields:Count);
      Fab1_33  = AData(20:nFields:Count);
      Fab1_12  = AData(21:nFields:Count);
      Fab1_13  = AData(22:nFields:Count);
      Fab1_23  = AData(23:nFields:Count);
      Fab2_11  = AData(24:nFields:Count);
      Fab2_22  = AData(25:nFields:Count);
      Fab2_33  = AData(26:nFields:Count);
      Fab2_12  = AData(27:nFields:Count);
      Fab2_13  = AData(28:nFields:Count);
      Fab2_23  = AData(29:nFields:Count);
      Vfab     = AData(30:nFields:Count);
      eRatio   = AData(31:nFields:Count);
      e_eff    = AData(32:nFields:Count);
      Knrgy    = AData(33:nFields:Count);
      Pnrgy    = AData(34:nFields:Count);
      Slidet   = AData(35:nFields:Count);
      Viscbt   = AData(36:nFields:Count);
      Viscct   = AData(37:nFields:Count);
      Work1t   = AData(38:nFields:Count);
      Nslide   = AData(39:nFields:Count);
      Nnear    = AData(40:nFields:Count);
      Solidr   = AData(41:nFields:Count);
      StressSub11 = AData(42:nFields:Count);
      StressSub22 = AData(43:nFields:Count);
      StressSub33 = AData(44:nFields:Count);
      StressSub12 = AData(45:nFields:Count);
      StressSub13 = AData(46:nFields:Count);
      StressSub23 = AData(47:nFields:Count);
      FabSub11  = AData(48:nFields:Count);
      FabSub22  = AData(49:nFields:Count);
      FabSub33  = AData(50:nFields:Count);
      FabSub12  = AData(51:nFields:Count);
      FabSub13  = AData(52:nFields:Count);
      FabSub23  = AData(53:nFields:Count);
      NtacsSub  = AData(54:nFields:Count);
      Octavg = AData(55:nFields:Count);
      Octav2 = AData(56:nFields:Count);
%
      if AFileVersion==151
        pfluid = AData(57:nFields:Count);
        defw =   AData(58:nFields:Count);
        fpnrgy = AData(59:nFields:Count);
        spnrgy = AData(60:nFields:Count);
      elseif AFileVersion==161
        pfluid = AData(57:nFields:Count);
        defw =   AData(58:nFields:Count);
        fpnrgy = AData(59:nFields:Count);
        spnrgy = AData(60:nFields:Count);
        S_now =  AData(61:nFields:Count);
      end
%
    elseif AFileVersion==122 || AFileVersion==152 || AFileVersion==162
%
      if AFileVersion==122
        nFields = 57;
      elseif AFileVersion==152
        nFields = 61;
      elseif AFileVersion==162
        nFields = 62;
      end
%
      TEMPLATE = TabTemplate(nFields);
      [AData, Count] = fscanf(Afile, TEMPLATE);
      Time =     AData( 1:nFields:Count);
      Def11 =    AData( 2:nFields:Count);
      Def22 =    AData( 3:nFields:Count);
      Def33 =    AData( 4:nFields:Count);
      Def12 =    AData( 5:nFields:Count);
      Def13 =    AData( 6:nFields:Count);
      Def23 =    AData( 7:nFields:Count);
      Stress11 = AData( 8:nFields:Count);
      Stress22 = AData( 9:nFields:Count);
      Stress33 = AData(10:nFields:Count);
      Stress12 = AData(11:nFields:Count);
      Stress13 = AData(12:nFields:Count);
      Stress23 = AData(13:nFields:Count);
      Chi1     = AData(14:nFields:Count);
      Chi2     = AData(15:nFields:Count);
      Psi      = AData(16:nFields:Count);
      ntacts   = AData(17:nFields:Count);
      Fab1_11  = AData(18:nFields:Count);
      Fab1_22  = AData(19:nFields:Count);
      Fab1_33  = AData(20:nFields:Count);
      Fab1_12  = AData(21:nFields:Count);
      Fab1_13  = AData(22:nFields:Count);
      Fab1_23  = AData(23:nFields:Count);
      Fab2_11  = AData(24:nFields:Count);
      Fab2_22  = AData(25:nFields:Count);
      Fab2_33  = AData(26:nFields:Count);
      Fab2_12  = AData(27:nFields:Count);
      Fab2_13  = AData(28:nFields:Count);
      Fab2_23  = AData(29:nFields:Count);
      Vfab     = AData(30:nFields:Count);
      eRatio   = AData(31:nFields:Count);
      e_eff    = AData(32:nFields:Count);
      Knrgy    = AData(33:nFields:Count);
      Pnrgy    = AData(34:nFields:Count);
      Slidet   = AData(35:nFields:Count);
      Viscbt   = AData(36:nFields:Count);
      Viscct   = AData(37:nFields:Count);
      Work1t   = AData(38:nFields:Count);
      Nslide   = AData(39:nFields:Count);
      Nnear    = AData(40:nFields:Count);
      Solidr   = AData(41:nFields:Count);
      StressSub11 = AData(42:nFields:Count);
      StressSub22 = AData(43:nFields:Count);
      StressSub33 = AData(44:nFields:Count);
      StressSub12 = AData(45:nFields:Count);
      StressSub13 = AData(46:nFields:Count);
      StressSub23 = AData(47:nFields:Count);
      FabSub11  = AData(48:nFields:Count);
      FabSub22  = AData(49:nFields:Count);
      FabSub33  = AData(50:nFields:Count);
      FabSub12  = AData(51:nFields:Count);
      FabSub13  = AData(52:nFields:Count);
      FabSub23  = AData(53:nFields:Count);
      NtacsSub  = AData(54:nFields:Count);
      Octavg = AData(55:nFields:Count);
      Octav2 = AData(56:nFields:Count);
      ntactz = AData(57:nFields:Count);
%
      if AFileVersion==152
        pfluid = AData(58:nFields:Count);
        defw =   AData(59:nFields:Count);
        fpnrgy = AData(60:nFields:Count);
        spnrgy = AData(61:nFields:Count);
      elseif AFileVersion==162
        pfluid = AData(58:nFields:Count);
        defw =   AData(59:nFields:Count);
        fpnrgy = AData(60:nFields:Count);
        spnrgy = AData(61:nFields:Count);
        S_now =  AData(62:nFields:Count);
      end
%
    end
    AData(1:nFields);
  fclose(Afile);
