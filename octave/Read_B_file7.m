function [Time, Def11, Def22, Def33, Def12, Def13, Def23, ...
          Stress11, Stress22, Stress33, Stress12, Stress13, Stress23, ...
          ntacts, ...
          knrgy, pnrgy, slidet, work1t, viscbt, viscct, ...
          chia1, psi, chia2, chia3, chia4, xloops, ...
          StressExt11, StressExt12, StressExt21, StressExt22, ...
          Stress21, TorqueInt3, TorqueStressInt13, TorqueStressInt23, ...
          HigherOrderStressInt121, HigherOrderStressInt122, ...
          TorqueExt3, TorqueStressExt13, TorqueStressExt23, ...
          HigherOrderStressExt121, HigherOrderStressExt122, ...
          HigherOrderStressInt221, HigherOrderStressInt112, ...
          HigherOrderStressExt221, HigherOrderStressExt112, ...
          Vcell, Ixcell1, Ixcell2, ...
          InteriorStress11, InteriorStress22, InteriorStress12, ...
          InteriorStressAsym, InteriorTorqueStress13, ...
          InteriorTorqueStress23, InteriorHigherOrderStress121, ...
          InteriorHigherOrderStress122, InteriorHigherOrderStress221, ...
          InteriorHigherOrderStress112, InteriorIntTorque3, ...
          InteriorVolume, TotalContacts, ...
          pfluid, defw, fpnrgy, spnrgy, S_now] = ...
   Read_B_file7(BfileDirectory, B_file_name);
%
% |+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|
%
% This function reads an OVAL or DEMPLA A-file and returns arrays
% with varous A-file output. The function call is given below.  The
% input arguments are as follows:
%   BfileDirectory  character string of the directory that holds the B-file,
%                   including the ending "/" (Linux or MacOS) or "\" (Windows)
%   B_file_name     character string of the file, including the leading "B"
%
% Dependencies:  none
%
% Function call...
%
% [ Time, Def11, Def22, Def33, Def12, Def13, Def23, ...
%   Stress11, Stress22, Stress33, Stress12, Stress13, Stress23, ...
%   ntacts, ...
%   knrgy, pnrgy, slidet, work1t, viscbt, viscct, ...
%   chia1, psi, chia2, chia3, chia4, xloops, ...
%   StressExt11, StressExt12, StressExt21, StressExt22, ...
%   Stress21, TorqueInt3, TorqueStressInt13, TorqueStressInt23, ...
%   HigherOrderStressInt121, HigherOrderStressInt122, ...
%   TorqueExt3, TorqueStressExt13, TorqueStressExt23, ...
%   HigherOrderStressExt121, HigherOrderStressExt122, ...
%   HigherOrderStressInt221, HigherOrderStressInt112, ...
%   HigherOrderStressExt221, HigherOrderStressExt112, ...
%   Vcell, Ixcell1, Ixcell2, ...
%   InteriorStress11, InteriorStress22, InteriorStress12, ...
%   InteriorStressAsym, InteriorTorqueStress13, ...
%   InteriorTorqueStress23, InteriorHigherOrderStress121, ...
%   InteriorHigherOrderStress122, InteriorHigherOrderStress221, ...
%   InteriorHigherOrderStress112, InteriorIntTorque3, ...
%   InteriorVolume, TotalContacts, ...
%   pfluid, defw, fpnrgy, spnrgy, S_now] = ...
% Read_B_file7(BfileDirectory, B_file_name);
%
%
  Time = [];
  Def11 = [];
  Def22 = [];
  Def33 = [];
  Def12 = [];
  Def13 = [];
  Def23 = [];
  Stress11 = [];
  Stress22 = [];
  Stress33 = [];
  Stress12 = [];
  Stress13 = [];
  Stress23 = [];
  ntacts = [];
%
  StressExt11 = [];
  StressExt12 = [];
  StressExt21 = [];
  StressExt22 = [];
  Stress21 = [];
%
  knrgy = [];
  pnrgy = [];
  slidet = [];
  work1t = [];
  viscbt = [];
  viscct = [];
%
  chia1 =  [];
  psi =    [];
  chia2 =  [];
  chia3 =  [];
  chia4 =  [];
  xloops = [];
%
  TorqueInt3 = [];
  TorqueStressInt13 = [];
  TorqueStressInt23 = [];
  HigherOrderStressInt121 = [];
  HigherOrderStressInt122 = [];
  HigherOrderStressInt221 = [];
  HigherOrderStressInt112 = [];
%
  TorqueExt3 = [];
  TorqueStressExt13 = [];
  TorqueStressExt23 = [];
  HigherOrderStressExt121 = [];
  HigherOrderStressExt122 = [];
  HigherOrderStressExt221 = [];
  HigherOrderStressExt112 = [];
  Vcell = [];
  Ixcell1 = [];
  Ixcell2 = [];
%
  InteriorStress11 = [];
  InteriorStress22 = [];
  InteriorStress12 = [];
  InteriorStressAsym = [];
  InteriorTorqueStress13 = [];
  InteriorTorqueStress23 = [];
  InteriorHigherOrderStress121 = [];
  InteriorHigherOrderStress122 = [];
  InteriorHigherOrderStress221 = [];
  InteriorHigherOrderStress112 = [];
  InteriorIntTorque3 = [];
  InteriorVolume = [];
  TotalContacts = [];
%
  pfluid = [];
  defw =   [];
  fpnrgy = [];
  spnrgy = [];
  S_now =  [];
%
  BFileName = strcat(BfileDirectory, B_file_name);
%
  if ~exist(BFileName, 'file')
    disp('*** File does not exist for Read_B_file6.m: *** ')
    disp(BFileName)
  end
%
  Bfile = fopen(BFileName,'r');
  TEMPLATE = '%i%*74%';
  [BFileType, COUNT] = fscanf(Bfile, TEMPLATE, 1);
  fclose(Bfile);
%
  Bfile = fopen(BFileName,'r');
% fseek (Bfile, 79);
  fgetl(Bfile);
%
  BFileName;
%
if BFileType == 10 || BFileType == 20 || BFileType == 30 
%
  TEMPLATE = '%e %e %e %e %e %i\n %e %e %e %e %e %e\n %e %e %e %e %e %e %f';
%
  if BFileType == 10
    nFields = 19;
  elseif BFileType == 20
    TEMPLATE = cstrcat(TEMPLATE, '\n %e %e %e %e');
    nFields = 23;
  elseif BFileType == 30
    TEMPLATE = cstrcat(TEMPLATE, '\n %e %e %e %e %e');
    nFields = 24;
  end
  [BData, Count] = fscanf(Bfile, TEMPLATE);
  Time =     BData( 1:nFields:Count);
  Def11 =    BData( 2:nFields:Count);
  Def22 =    BData( 3:nFields:Count);
  Def12 =    BData( 4:nFields:Count);
%
  Stress11 = BData(8:nFields:Count);
  Stress22 = BData(9:nFields:Count);
  Stress12 = BData(10:nFields:Count);
%
  knrgy = BData(5:nFields:Count);
  pnrgy = BData(11:nFields:Count);
  slidet = BData(17:nFields:Count);
  work1t = BData(18:nFields:Count);
  viscbt = BData(16:nFields:Count);
%
  chia1 =  BData( 7:nFields:Count);
  psi =    BData(12:nFields:Count);
  chia2 =  BData(13:nFields:Count);
  chia3 =  BData(14:nFields:Count);
  chia4 =  BData(15:nFields:Count);
  xloops = BData(19:nFields:Count);
%
  ntacts = BData( 6:19:Count);
  ndim = 2;
  Def33 = 0; Def13 = 0; Def23 = 0; Stress33 = 0; Stress13 = 0; Stress23 = 0;
%
  if BFileType == 20
    pfluid = BData(20:nFields:Count);
    defw =   BData(21:nFields:Count);
    fpnrgy = BData(22:nFields:Count);
    spnrgy = BData(23:nFields:Count);
  elseif BFileType == 30
    pfluid = BData(20:nFields:Count);
    defw =   BData(21:nFields:Count);
    fpnrgy = BData(22:nFields:Count);
    spnrgy = BData(23:nFields:Count);
    S_now =  BData(24:nFields:Count);
  end
%
elseif BFileType == 11 || BFileType == 17 ...
    || BFileType == 21 || BFileType == 27 ...
    || BFileType == 31 || BFileType == 37 ...
    || BFileType == 41 || BFileType == 47
%
  if BFileType == 27 || BFileType == 37 || BFileType == 47
%   skip lines 2 thru 4 of header information
    fgetl(Bfile);
    fgetl(Bfile);
    fgetl(Bfile);
  end
%
  TEMPLATE = cstrcat('%e %e %e %e %e %i\n %e %e %e %e %e\n', ...
                     ' %e %e %e %e %e\n %e %e %e %e %e\n %e %e %e %e %f');
  if BFileType == 11 || BFileType == 17
    nFields = 26;
  elseif BFileType == 21 || BFileType == 27
    TEMPLATE = cstrcat(TEMPLATE, '\n %e %e %e %e');
    nFields = 30;
  elseif BFileType == 31 || BFileType == 37 || BFileType == 47
    TEMPLATE = cstrcat(TEMPLATE, '\n %e %e %e %e %e');
    nFields = 31;
  end
%
  [BData, Count] = fscanf(Bfile, TEMPLATE);
  Time =     BData( 1:nFields:Count);
  Def11 =    BData( 2:nFields:Count);
  Def22 =    BData( 3:nFields:Count);
  Def33 =    BData( 4:nFields:Count);
  Def12 =    BData( 8:nFields:Count);
  Def13 =    BData( 9:nFields:Count);
  Def23 =    BData(10:nFields:Count);
%
  Stress11 = BData(13:nFields:Count);
  Stress22 = BData(14:nFields:Count);
  Stress33 = BData(15:nFields:Count);
  Stress12 = BData(18:nFields:Count);
  Stress13 = BData(19:nFields:Count);
  Stress23 = BData(20:nFields:Count);
%
  knrgy =  BData(5:nFields:Count);
  pnrgy =  BData(11:nFields:Count);
  slidet = BData(16:nFields:Count);
  work1t = BData(21:nFields:Count);
  viscbt = BData(24:nFields:Count);
  viscct = BData(25:nFields:Count);
%
  chia1 =  BData( 7:nFields:Count);
  psi =    BData(23:nFields:Count);
  chia2 =  BData(12:nFields:Count);
  chia3 =  BData(17:nFields:Count);
  chia4 =  BData(22:nFields:Count);
  xloops = BData(26:nFields:Count);
%
  ntacts = BData( 6:nFields:Count);
%
  if BFileType == 21 || BFileType == 27
    pfluid = BData(27:nFields:Count);
    defw =   BData(28:nFields:Count);
    fpnrgy = BData(29:nFields:Count);
    spnrgy = BData(30:nFields:Count);
  elseif BFileType == 31 || BFileType == 37
    pfluid = BData(27:nFields:Count);
    defw =   BData(28:nFields:Count);
    fpnrgy = BData(29:nFields:Count);
    spnrgy = BData(30:nFields:Count);
    S_now =  BData(31:nFields:Count);
  end
%
  ndim = 3;
elseif BFileType == 12 || BFileType == 22 || BFileType == 32 || BFileType == 42
%
  if BFileType == 22 || BFileType == 32 || BFileType == 42
%   skip lines 2 thru 4 of header information
    fgetl(Bfile);
    fgetl(Bfile);
    fgetl(Bfile);
  end
%
% A template that skips over data that is zero
  TEMPLATE = cstrcat( ...
           '%e %e %e %e %i\n %e %e %e %e Tot \n %e %e %e %e dTot\n', ...
           ' %e %e %e   %e I   \n %e %e %e %e', ...
           ' II  \n%*62c\n%*62c\n%*62c\n%*62c\n %e %e %e %e', ...
           ' III \n%*62c\n%*62c\n %e %e %e %e', ...
           ' IIId\n%*62c\n%*62c\n%*62c\n%*62c\n%*62c\n%*62c\n', ...
           '%*62c\n%*62c\n', ...
           ' %e %e %e %e %i\n %e %e %e %e\n %e %e');
  if BFileType == 12
    nFields = 40;
  elseif BFileType == 22
    TEMPLATE = cstrcat(TEMPLATE, '\n %e %e %e %e');
    nFields = 44;
  elseif BFileType == 32
    TEMPLATE = cstrcat(TEMPLATE, '\n %e %e %e %e %e');
    nFields = 45;
  end
%
  [BData, Count] = fscanf(Bfile, TEMPLATE);
  Time =     BData( 1:nFields:Count);
  Def11 =    BData( 2:nFields:Count);
  Def22 =    BData( 3:nFields:Count);
  nBdata = size(Def11);
  Def33 =    zeros(nBdata);
  Def12 =    BData( 4:nFields:Count);
  Def13 =    zeros(nBdata);
  Def23 =    zeros(nBdata);
%
  Stress11 = BData(6:nFields:Count);
  Stress22 = BData(9:nFields:Count);
  Stress33 = zeros(nBdata);
  Stress12 = BData(7:nFields:Count);
  Stress13 = zeros(nBdata);
  Stress23 = zeros(nBdata);
%
  knrgy =  BData( 5:nFields:Count);
  pnrgy =  BData(11:nFields:Count);
  slidet = BData(16:nFields:Count);
  work1t = BData(21:nFields:Count);
  viscbt = BData(24:nFields:Count);
  viscct = BData(25:nFields:Count);
%
  chia1 =  BData( 7:nFields:Count);
  psi =    BData(23:nFields:Count);
  chia2 =  BData(12:nFields:Count);
  chia3 =  BData(17:nFields:Count);
  chia4 =  BData(22:nFields:Count);
  xloops = BData(26:nFields:Count);
%
  ntacts = BData( 6:nFields:Count);
%
  if BFileType==22
    pfluid = BData(41:nFields:Count);
    defw =   BData(42:nFields:Count);
    fpnrgy = BData(43:nFields:Count);
    spnrgy = BData(44:nFields:Count);
  elseif BFileType==32
    pfluid = BData(41:nFields:Count);
    defw =   BData(42:nFields:Count);
    fpnrgy = BData(43:nFields:Count);
    spnrgy = BData(44:nFields:Count);
    S_now =  BData(45:nFields:Count);
  end
%
elseif BFileType==14 || BFileType==16 || BFileType==24 || BFileType==26
  TEMPLATE = cstrcat('%e %e %e %e %e %i\n %e %e %e %e %e %e\n', ...
                     ' %e %e %e %e %e %e %f\n %e %e %e %e %e\n', ...
                     ' %e %e %e %e %e\n %e %e %e %e %e\n', ...
                     ' %e %e %e %e\n %e %e %e');
  if BFileType==16
    TEMPLATE = strcat(TEMPLATE, ...
                      '\n %e %e %e %e %e\n %e %e %e %e %e\n %e %e %i');
    nFields = 54;
  elseif BFileType==14
    nFields = 41;
  elseif BFileType==26
    TEMPLATE = strcat(TEMPLATE, ...
               '\n %e %e %e %e %e\n %e %e %e %e %e\n %e %e %i\n %e %e %e %e');
    nFields = 58;
  elseif BFileType==36
    TEMPLATE = strcat(TEMPLATE, ...
               '\n %e %e %e %e %e\n %e %e %e %e %e\n %e %e %i\n %e %e %e %e %e');
    nFields = 59;
  elseif BFileType==24
    nFields = 45;
  elseif BFileType==26
    nFields = 46;
  end
%
  [BData, Count] = fscanf(Bfile, TEMPLATE);
  Time =     BData( 1:nFields:Count);
  Def11 =    BData( 2:nFields:Count);
  Def22 =    BData( 3:nFields:Count);
  Def12 =    BData( 4:nFields:Count);
%
  Stress11 = BData(8:nFields:Count);
  Stress22 = BData(9:nFields:Count);
  Stress12 = BData(10:nFields:Count);
%
  ntacts = BData( 6:nFields:Count);
%
  StressExt11 = BData(20:nFields:Count);
  StressExt12 = BData(21:nFields:Count);
  StressExt21 = BData(22:nFields:Count);
  StressExt22 = BData(23:nFields:Count);
  StressDiff = BData(24:nFields:Count);
%
  Stress21 = Stress12 - StressDiff;
  Stress12 = Stress12 + StressDiff;
%
  TorqueInt3 = BData(25:nFields:Count);
  TorqueStressInt13 = BData(26:nFields:Count);
  TorqueStressInt23 = BData(27:nFields:Count);
  HigherOrderStressInt121 = BData(28:nFields:Count);
  HigherOrderStressInt122 = BData(29:nFields:Count);
%
  TorqueExt3 = BData(30:nFields:Count);
  TorqueStressExt13 = BData(31:nFields:Count);
  TorqueStressExt23 = BData(32:nFields:Count);
  HigherOrderStressExt121 = BData(33:nFields:Count);
  HigherOrderStressExt122 = BData(34:nFields:Count);
%
  HigherOrderStressInt221 = BData(35:nFields:Count);
  HigherOrderStressInt112 = BData(36:nFields:Count);
  HigherOrderStressExt221 = BData(37:nFields:Count);
  HigherOrderStressExt112 = BData(38:nFields:Count);
%
  Vcell =   BData(39:nFields:Count);
  Ixcell1 = BData(40:nFields:Count);
  Ixcell2 = BData(41:nFields:Count);
%
  InteriorStress11 = BData(42:nFields:Count);
  InteriorStress22 = BData(43:nFields:Count);
  InteriorStress12 = BData(44:nFields:Count);
  InteriorStressAsym = BData(45:nFields:Count);
  InteriorTorqueStress13 = BData(46:nFields:Count);
  InteriorTorqueStress23 = BData(47:nFields:Count);
  InteriorHigherOrderStress121 =  BData(48:nFields:Count);
  InteriorHigherOrderStress122 =  BData(49:nFields:Count);
  InteriorHigherOrderStress221 =  BData(50:nFields:Count);
  InteriorHigherOrderStress112 =  BData(51:nFields:Count);
  InteriorIntTorque3 = BData(52:nFields:Count);
  InteriorVolume = BData(53:nFields:Count);
  TotalContacts = BData(54:nFields:Count);
%
  if BFileType==24 || BFileType==26
    pfluid = BData(nFields-3:nFields:Count);
    defw =   BData(nFields-2:nFields:Count);
    fpnrgy = BData(nFields-1:nFields:Count);
    spnrgy = BData(nFields:nFields:Count);
  elseif BFileType==34 || BFileType==36
    pfluid = BData(nFields-4:nFields:Count);
    defw =   BData(nFields-3:nFields:Count);
    fpnrgy = BData(nFields-2:nFields:Count);
    spnrgy = BData(nFields-1:nFields:Count);
    S_now =  BData(nFields:nFields:Count);
  end
%
  ndim = 2;
  Def33 = 0; Def13 = 0; Def23 = 0; Stress33 = 0; Stress13 = 0; Stress23 = 0;
%
  ndim = 2;
end
%
fclose(Bfile);
%
if isempty(Def11)
  disp('*** Perhaps file is not a B-type file: *** ')
  disp(BFileName)
end
