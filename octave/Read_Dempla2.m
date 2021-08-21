function [nRVEs, dt_rve, dx_rve, nDempla_out, z] = ...
         Read_Dempla2(HeadFolder, BaseName, Suffix, MotionInput, Content);
%
% |+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|
%
% This function reads an DEMPLA "Results_" file, with various types 
% of output from a Mode 2 wave propagation simulation.  This function
% assumes that these "Results_" files will reside in the "04_RunOutput" 
% sub-directory of the BaseName directory
%
% INPUT:
% HeadFolder    the character string name of the top-level directory
%               This is the folder that contains the BaseName directory.
%               The string should end with the directory separator:
%               "/" on Linux systems
% BaseName      the character string BaseName of the simulation.
%               Do NOT place a "/" at the end of this name.
% Suffix        the character string suffix of the G-File that is appended 
%               to the BaseName
% MotionInput   the character string name of the MotionInput file
% Content       the character string name of the type of results file:
%               'u_1'         soil displacements (m)
%               'u_2'
%               'u_3'
%               's_11'        soil total stresses (Pa)
%               's_22'
%               's_33'
%               's_12'        soil shear stressePas
%               's_13'
%               's_23'
%               'w'           fluid displacement (m)
%               'p'           fluid (liquid) pressure (Pa)
%               'rho_soil'    density of bulk soil (kg/m^3)
%               'rho_fluid'   density of fluid (kg/m^3)
%               'Porosity'    porosity of soil
%               'kperm'       hydraulic conductivity (m/s)
%               'sat'         saturation of pore fluid
%               'water'       water table level (m)
%               'time'        time (s)
%               'I'           inertia number
%               'kn'          mean contact stiffness
%               'chi'         performance parameter
%               'mass'        scaled particle mass
%               'steps'       DEM steps per \Delta t time
% iResultsType  type of output:
%                 0 - each row contains the data for N RVEs
%                 1 - each row contains the data for N+1 Nodes
%                 2 - each row contains two data items
%                 3 - each row contains one data item
%
% OUTPUT:
% nRVEs        number of RVEs in the soil column
% dt_rve       the Dempla time step:  \Delta t
% dx_rve       the thickness each soil column element
% nDempla_out  the number of Dempla time steps per line of output
% z            the output data
%                if iResultsType==0, z has nRVEs columns, and as many rows
%                                    as there lines in the "Results_" file
%                if iResultsType==1, z has nRVEs+1 columns, and as many rows
%                                    as there lines in the "Results_" file
%                if iResultsType==2, z has 2 columns, and as many rows
%                                    as there lines in the "Results_" file
%                if iResultsType==3, z has 1 column, and as many rows
%                                    as there lines in the "Results_" file

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
% [nRVEs, dt_rve, dx_rve, nDempla_out, z] = ...
%  Read_Dempla2(HeadFolder, BaseName, Suffix, MotionInput, Content);
%
% build the file name
  File = cstrcat(HeadFolder, ...
                 BaseName, ...
                 '/04_RunOutput/', ...
                 'Results_', ...
                 Content, ...
                 '_', ...
                 BaseName, ...
                 Suffix, ...
                 '_', ...
                 MotionInput, ...
                 '.txt');
%
% does the file even exist?
  if ~exist(File, 'file')
    disp('*** File does not exist for Read_Dempla2.m: *** ')
    disp(File)
  end
%
% Open the file for reading
  FileNo = fopen(File,'r');
%
% The opening 5 lines in the Results file
  [iResultsType, COUNT] = fscanf(FileNo, '%i', 1);
  [nRVEs, COUNT] =        fscanf(FileNo, '%i', 1);
  [dt_rve, COUNT] =       fscanf(FileNo, '%e', 1);
  [dx_rve, COUNT] =       fscanf(FileNo, '%e', 1);
  [nDempla_out, COUNT] =  fscanf(FileNo, '%i', 1);
%
% the number of data items in each row of the file
  if iResultsType==0
    RowLength = nRVEs;
  elseif iResultsType==1
    RowLength = nRVEs + 1;
  elseif iResultsType==2
    RowLength = 2;
  elseif iResultsType==3
    RowLength = 1;
  else
    'Incorrect value iResultsType in function Read_Dempla2.m'
    ERROR_
  end
%
  if iResultsType==0 || iResultsType==1
    [SCAN, COUNT] = fscanf(FileNo, '%e');
    z = reshape(SCAN, RowLength, length(SCAN)/RowLength);
%
  elseif iResultsType==2 || iResultsType==3
    [SCAN, COUNT] = fscanf(FileNo, '%e');
    z = zeros(COUNT/RowLength, RowLength);
    for i = 1:RowLength
      z(:,i) = SCAN(i:RowLength:COUNT);
    end
  end
%
% close the file and release the file number
  fclose(FileNo);
