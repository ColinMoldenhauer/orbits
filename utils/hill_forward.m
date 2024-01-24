function r = hill_forward(r0, v0, n, t)
% Computes the Hill Equations for user-specified time steps
% from given initial conditions.
%
%   param r0:       initial position [m]        size (3,1)
%   param v0:       initial velocity [m/s]      size (3,1)
%   param n:        mean motion of circular reference orbit
%   param t:        time vector                 size (N,1)
%
%   returns r:      relative position [m]       size (N,3)
%   TODO: r is relative position or absolute of perturbed orbit
    x0 = r0(1);
    y0 = r0(2);
    z0 = r0(3);
    vx0 = v0(1);
    vy0 = v0(2);
    vz0 = v0(3);

    x = 2/n * vz0 * cos(n*t) + (4/n * vx0 + 6*z0) * sin(n*t) - (3*vx0 + 6*n*z0)*t + x0 - 2/n * vz0;
    y = y0 * cos(n*t) + vy0/n * sin(n*t);
    z = (-2/n*vx0 - 3*z0)*cos(n*t) + vz0/n*sin(n*t) + 2/n*vx0 + 4*z0;

    r = [x y z];
end