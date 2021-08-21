function Write_Dfile_Ovoids(FilePath, ...
                            Shape, ...
                            xcell, ...
                            rad, ...
                            xp, ...
                            Beta_rad, ...
                            Aspect, ...
                            gamma);
%
% |+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|+|
%
% This function creates an OVAL or DEMPLA D-file for an ovoid shape
% (a composite of two sphere caps and a torus, kshape=5).  
% The function call is given below.  The input arguments are as follows:
%   FilePath  character string of the D-File that will be created.
%             Should include the full path with director separators,
%             "/" (Linux or MacOS) or "\" (Windows)
%   Shape     should be 5 (kshape).  Otherwise, an error is printed
%   xcell     the 3x3 matrix that gives dimensions and offsets of 
%             the periodic cell
%   rad       the 1 x np vector that gives the base size of each particle
%   xp        the 3 x np matrix that gives the locations of the centers
%             of each particles
%   Beta_rad  the scalar beta angle in radians.  All particles will share
%             this scalar value.
%   Aspect    the 1 x np vector that gives the aspect ratios of the particles.
%             In the current version of DEMPLA, all particles must have the
%             same aspect ratio.
%   gamma     the 2 x np matrix of Euler angles of the particles' orientations
%
% Dependencies:  Shapes3
%
% Function call...
% Write_Dfile_Ovoids(FilePath, ...
%                    Shape, ...
%                    xcell, ...
%                    rad, ...
%                    xp, ...
%                    Beta_rad, ...
%                    Aspect, ...
%                    gamma);
%
%
  [Circle, Oval, Ellipse, Sphere, Ovoid, Nobby, Bumpy] = Shapes3();
%
  if Shape==5
    FileNo = fopen(FilePath,'w');
    fprintf(FileNo, '%1i\n', Shape);
    fprintf(FileNo, '%6i', length(rad));
    fprintf(FileNo, '%25.17e%25.17e%25.17e\n', xcell(1,1), xcell(2,2), xcell(3,3))
    fprintf(FileNo, '      %25.17e%25.17e%25.17e\n', xcell(1,2), xcell(1,3), xcell(2,3))
    fprintf(FileNo, '%25.17e\n', Beta_rad*180/pi)
    fprintf(FileNo, '%25.17e%25.17e%25.17e%25.17e%25.17e%25.17e%25.17e\n', ...
                    [rad, Aspect, xp, gamma]');
    fclose(FileNo);
  else
    '***** Wrong shape in Write_Dfile_Ovoids *****';
  end
