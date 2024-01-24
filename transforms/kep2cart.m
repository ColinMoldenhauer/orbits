function [r, v] = kep2cart(t, a, e, incl, raan, aop, T0, from_perigee)
    % INPUTS
    %   t       time vector [s]
    %   a       semi-major axis [km]
    %   e       eccentricity [-]
    %   incl    inclination [deg]
    %   raan    right ascension of ascending node [deg]
    %   aop     argument of perigee [deg]
    %   T0      perigee passing time [s]

    % OUTPUTS
    %   r       position vector in cartesian space-fixed system [m]
    %   v       position vector in cartesian space-fixed system [m/s]
    
    GM = 398.6005 * 1e12;

    incl = deg2rad(incl);
    raan = deg2rad(raan);
    aop = deg2rad(aop);

    [r_pol, nu] = kep2orb(t, a, e, T0, from_perigee);
    
    z = zeros(1, size(nu, 2));

    r_orb = r_pol .* [cos(nu); sin(nu); z];
    v_orb = sqrt(GM/((a.*1000)*(1-e.^2))) .* [-sin(nu); e+cos(nu); z];
    
    R = R3(-raan)*R1(-incl)*R3(-aop);

    r = R*r_orb;
    v = R*v_orb;
end


function R = R1(alpha)
    R = [1,           0,          0;
         0,  cos(alpha), sin(alpha);
         0, -sin(alpha), cos(alpha)];
end

function R = R2(alpha)
    R = [cos(alpha), 0, -sin(alpha);
                  0, 1,           0;
         sin(alpha), 0,  cos(alpha)];
end

function R = R3(alpha)
    R = [ cos(alpha), sin(alpha), 0;
         -sin(alpha), cos(alpha), 0;
                   0,          0, 1];
end