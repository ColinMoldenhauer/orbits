function [x, y, z] = get_RSW_basis(r, v)
% Determines the RSW basis vectors from postion and velocity information of
% a satellite. Used in combination with project2orb.m to actually project
% vectors into the RSW frame.
%
%   r:          position vector in inertial frame            size (N,3)
%   v:          velocity vector in inertial frame            size (N,3)
%
%   [x y z]:    basis vectors x,y,z in rotating RSW frame   size each (N,3)

    z = r./vecnorm(r, 2, 2);
    cr = cross(r, v);
    y = cr./vecnorm(cr, 2, 2);
    x = cross(y, z);
end