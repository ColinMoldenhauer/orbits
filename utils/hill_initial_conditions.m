function [r0, v0] = hill_initial_conditions(r, n, t)
% Determines the initial conditions for the homogeneous Hill Equations
% from a set of position vectors.
%
%   r:      position vector                                 size (N, 3)
%   n:      mean motion of circular reference orbit         size (1)
%   t:      time vector                                     size (N, 1)
%
%   r0:     Initial position vector                         size (1, 3)


    xz = [r(:, 1); r(:, 3)];
    y = r(:, 2);

    dxdx0 = ones(size(y));
    dxdvx0 = 4/n .* sin(n*t) - 3*t;
    dxdz0 = 6*(sin(n*t) - n*t);
    dxdvz0 = 2/n * (cos(n*t) - 1);

    dzdx0 = zeros(size(y));
    dzdvx0 = 2/n*(1 - cos(n*t));
    dzdz0 = 4 - 3*cos(n*t);
    dzdvz0 = 1/n*sin(n*t);
    
    dydy0 = cos(n*t);
    dydvy0 = 1/n*sin(n*t);

    A_xz = [dxdx0 dxdvx0 dxdz0 dxdvz0;
            dzdx0 dzdvx0 dzdz0 dzdvz0];

    A_y = [dydy0 dydvy0];

    xz0 = (A_xz' * A_xz) \ (A_xz' * xz);
    y0 = (A_y' * A_y) \ (A_y' * y);
    
    r0 = [xz0(1), y0(1), xz0(3)];
    v0 = [xz0(2), y0(2), xz0(4)];
end