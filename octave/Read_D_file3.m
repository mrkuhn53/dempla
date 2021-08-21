function [Shape, xcell, np, ...
          HalfWidth, Aspect, x, theta, gamma, Beta_rad, Beta, ...
          nobs, nbumps, satrad, cenrad, cirrad, Qp] =  ...
  Read_D_file3(Directory, File)
%
% This function reads a D-file (a text StartFile)
%
% Input
%   Directory = character string name of the directory that holds the D-file,
%               including the trailing '/' (Linux or MacOS) or '\' (Windows)
%   File      = character string name of the D-file, including the leading 'D"
%
% Dependencies:  Shapes3();
%
% Function call:
%
% [Shape, xcell, np, ...
%  HalfWidth, Aspect, x, theta, gamma, Beta_rad, Beta, ...
%  nobs, nbumps, satrad, cenrad, cirrad, Qp] =  ...
% Read_D_file3(Directory, File);
%
% Output
%   Shape     = iShape, particle shape (1, 2, 3, 4, 5, 6, or 7)
%   xcell     = cell dimensions (3x3 matrix of cell size)
%   np        = number of particles
%   HalfWidth = particle dimension (radius of circles, etc.)
%   Aspect    = aspect ratio of ovals, ovoids, and ellipses
%   x         = particle positions (np x 3 matrix)
%   theta     = orientation angle of non-circular 2D particles, degrees
%   gamma     = gamma orientation angles of ovoids, (np x 2 matrix), degrees
%   Beta_rad  = beta angle of ovals and ovoids, radians
%   Beta      = beta angle of ovals and ovoids, degrees
%   nobs      = number of nobs (satellite circles) of nobby particles
%   nbumps    = number of satellite spheres of bumpy particles
%   satrad    = radius of satellite (necklace) circles (spheres) relative 
%               to the necklace radius (bumpy and nobby particles)
%   cenrad    = radius of the central circle (or sphere) (bumpy and nobby
%               particles)
%   cirrad    = radius of the circumsphere of satellite sphere centers
%               (bumpy particles)
%   Qp        = quaternion of particle rotation (bumpy particles)
%
HalfWidth=0; Aspect=0; x=0; theta=0; gamma=0; Beta_rad=0; Beta=0; np=0;
nobs = 0; satrad = 0; cenrad = 0; Shape = 0; nbumps = 0; cirrad = 0; Qp = 0;
satrad = 0;
%
[Circle, Oval, Ellipse, Sphere, Ovoid, Nobby, Bumpy] = Shapes3();
%
DFileName = cstrcat(Directory, File);
%
if ~exist(DFileName, 'file')
  disp('*** File does not exist for Read_D_file3.m: *** ')
  disp(DFileName)
end
%
DFile = fopen(DFileName, 'r');
  TEMPLATE = '%i\n%i %e %e %e\n %e %e %e';
  [Data, COUNT] = fscanf(DFile, TEMPLATE, 8);
%
Shape = Data(1);
np = Data(2);
xcell = zeros(3,3); 
xcell(1,1) = Data(3); xcell(2,2) = Data(4); xcell(3,3) = Data(5);
xcell(1,2) = Data(6); xcell(1,3) = Data(7); xcell(2,3) = Data(8);
%
if Shape==Oval || Shape==Ovoid
   TEMPLATE = '%e';
   [Data, COUNT] = fscanf(DFile, TEMPLATE, 1);
   Beta = Data(1);
   Beta_rad = Beta * pi / 180;
elseif Shape==Nobby
   TEMPLATE = '%i\n%e %e';
   [Data, COUNT] = fscanf(DFile, TEMPLATE, 3);
   nobs = Data(1);
   satrad = Data(2);
   cenrad = Data(3);
elseif Shape==Bumpy
   TEMPLATE = '%i\n%e %e %e';
   [Data, COUNT] = fscanf(DFile, TEMPLATE, 4);
   nbumps = Data(1);
   satrad = Data(2);
   cenrad = Data(3);
   cirrad = Data(4);
end
%
fclose(DFile);
%
DFile = fopen(DFileName, 'r');
%
DFileName;
%
if Shape==Circle
  fseek(DFile, 166);
  TEMPLATE = '%e %e %e'; nColumns = 3;
  [A, Count] = fscanf(DFile, TEMPLATE);
  HalfWidth = A(1:nColumns:Count);
  x1 = A(2:nColumns:Count);
  x2 = A(3:nColumns:Count);
  x = [x1 x2];
elseif Shape==Oval
  fseek(DFile, 192);
  TEMPLATE = '%e %e %e %e %e'; nColumns = 5;
  [A, Count] = fscanf(DFile, TEMPLATE);
  HalfWidth = A(1:nColumns:Count);
  Aspect =    A(2:nColumns:Count);
  x1 =        A(3:nColumns:Count);
  x2 =        A(4:nColumns:Count);
  theta =     A(5:nColumns:Count);
  x = [x1 x2];
elseif Shape==Sphere
  fseek(DFile, 166);
  TEMPLATE = '%e %e %e %e'; nColumns = 4;
  [A, Count] = fscanf(DFile, TEMPLATE);
  HalfWidth = A(1:nColumns:Count);
  x1 =        A(2:nColumns:Count);
  x2 =        A(3:nColumns:Count);
  x3 =        A(4:nColumns:Count);
  x = [x1 x2 x3];
elseif Shape==Ovoid
  fseek(DFile, 192);
  TEMPLATE = '%e %e %e %e %e %e %e'; nColumns = 7;
  [A, Count] = fscanf(DFile, TEMPLATE);
  HalfWidth = A(1:nColumns:Count);
  Aspect =    A(2:nColumns:Count);
  x1 =        A(3:nColumns:Count);
  x2 =        A(4:nColumns:Count);
  x3 =        A(5:nColumns:Count);
  gamma1 =    A(6:nColumns:Count);
  gamma2 =    A(7:nColumns:Count);
  x = [x1 x2 x3];
  gamma = [gamma1 gamma2];
elseif Shape==Nobby
  fseek(DFile, 220);
  TEMPLATE = '%e %e %e %e'; nColumns = 4;
  [A, Count] = fscanf(DFile, TEMPLATE);
  HalfWidth = A(1:nColumns:Count);
  x1 =        A(2:nColumns:Count);
  x2 =        A(3:nColumns:Count);
  theta =     A(4:nColumns:Count);
  x = [x1 x2];
elseif Shape==Bumpy
  fseek(DFile, 245);
  TEMPLATE = '%e %e %e %e %e %e %e %e'; nColumns = 8;
  [A, Count] = fscanf(DFile, TEMPLATE);
  HalfWidth = A(1:nColumns:Count);
  x1 =        A(2:nColumns:Count);
  x2 =        A(3:nColumns:Count);
  x3 =        A(4:nColumns:Count);
  Qp1 =       A(5:nColumns:Count);
  Qp2 =       A(6:nColumns:Count);
  Qp3 =       A(7:nColumns:Count);
  Qp4 =       A(8:nColumns:Count);
  x = [x1 x2 x3];
  Qp = [Qp1 Qp2 Qp3 Qp4];
end
%
fclose(DFile);
