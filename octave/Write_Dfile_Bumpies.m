function Write_Dfile_Bumpies(FilePath, ...
                             Shape, ...
                             xcell, ...
                             rad, ...
                             xp, ...
                             nbumps, ...
                             satrad, cenrad, cirrad, ...
                             Qp);
%
% |+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|
%
% This function creates an OVAL or DEMPLA D-file for a bumpy shape
% (a sphere cluster, kshape=7).  The function call is given below.  The
% input arguments are as follows:
%   FilePath  character string of the D-File that will be created.
%             Should include the full path with director separators,
%             "/" (Linux or MacOS) or "\" (Windows)
%   Shape     should be 7.  Otherwise, an error is printed
%   xcell     the 3x3 matrix that gives dimensions and offsets of 
%             the periodic cell
%   rad       the 1 x np vector that gives the base size of each particle
%   xp        the 3 x np matrix that gives the locations of the centers
%             of each particles
%   nbumps    the scalar integer number of spheres (bumps) around the
%             central sphere
%   satrad    | these are the three scalars that give the relative
%   cenrad    | proportions of the spheres and their offsets from
%   cirrad    | the central sphere
%   Qp        the 4 x np matrix of the quaternian orientations
%
% Dependencies:  Shapes3
%
% Function call...
% Write_Dfile_Bumpies(FilePath, ...
%                     Shape, ...
%                     xcell, ...
%                     rad, ...
%                     xp, ...
%                     nbumps, ...
%                     satrad, cenrad, cirrad, ...
%                     Qp);
%
  [Circle, Oval, Ellipse, Sphere, Ovoid, Nobby, Bumpy] = Shapes3();
%
  if Shape==7
    FileNo = fopen(FilePath,'w');
    fprintf(FileNo, '%1i\n', Shape);
    fprintf(FileNo, '%6i', length(rad));
    fprintf(FileNo, '%25.17e%25.17e%25.17e\n', xcell(1,1), xcell(2,2), xcell(3,3))
    fprintf(FileNo, '      %25.17e%25.17e%25.17e\n', xcell(1,2), xcell(1,3), xcell(2,3))
    fprintf(FileNo, '%3i\n', nbumps)
    fprintf(FileNo, '%25.17e%25.17e%25.17e\n', satrad, cenrad, cirrad);
    fprintf(FileNo, '%25.17e%25.17e%25.17e%25.17e%25.17e%25.17e%25.17e%25.17e\n', ...
                    [rad, xp, Qp]');
    fclose(FileNo);
  else
    '***** Wrong shape in Write_Dfile_Bumpies *****';
  end
