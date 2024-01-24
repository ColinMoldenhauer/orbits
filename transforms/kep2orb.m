function [r, nu, M, E] = kep2orb(t, a, e, T0, from_perigee)
    % INPUTS
    %   t   time vector [s]
    %   a   semi-major axis [km]
    %   e   eccentricity [-]
    %   T0  perigee passing time [s]
    %
    %   from_perigee    whether to ignore T0 [boolean]

    % OUPUTS
    %   r   polar radius in 2D orbit [m]
    %   nu  true anomaly [rad]
    %   M   mean anomaly [rad]
    %   E   eccentric anomaly

    GM = 398.6005 * 1e12;

    % mean motion
    n = sqrt(GM/(a.*1000)^3);
    
    % time dependent mean anomaly
    if from_perigee
        M = mod(n * t, 2*pi);
    else
        M = mod(n * (t-T0), 2*pi);
    end
    
    % Kepler's equation -> solve iterately
    % M = E - e*sin(E)
    E = solve_E(M, e, 1e-6, 1e3);    
    
    % true anomaly
    nu = 2*atan2(sqrt((1+e) / (1-e)), 1./tan(E/2));
    % radius
    r = a .*1000 .* (1 - e.*cos(E));
end