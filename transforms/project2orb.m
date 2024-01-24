function out = project2orb(x, y, z, vec)
% Projects a vector into the frame given by basis vectors x, y, z.
% Use get_RSW_basis.m to obtain the basis vectors.
%
%   x:      x-axis basis vector             size (N, 3)
%   y:      y-axis basis vector             size (N, 3)
%   z:      z-axis basis vector             size (N, 3)
%   vec:    vector to be projected          size (N, 3)
%
%   out:    Projected vectors in new basis determined by x, y, z

    out = zeros(size(vec));
    out(:, 1) = dot(x, vec, 2);
    out(:, 2) = dot(y, vec, 2);
    out(:, 3) = dot(z, vec, 2);
end