function [r_e, v_e] = cart2efix(t, r_s, v_s, theta0)
    % INPUTS
    %   t         time vector [s]
    %   r_s       position vector given in space-fixed frame [m]
    %   v_s       velocity vector given in space-fixed frame [m/s]
    %   theta0    Greenwich Sidereal Time at time t=0 [rad]
    % OUTPUTS
    %   r_e     position vector in earth-fixed frame [m]
    %   v_e     velocity vector in earth-fixed frame [m/s]

    rad_vel_earth = 2*pi/86164;

    GST = theta0 + rad_vel_earth .* t;

    r_e = zeros(size(r_s));
    v_e = zeros(size(v_s));

    for i=1:size(GST,2)
        R = R_i(GST(1, i), 3);
        r_e(:, i) = R * r_s(:, i);
        v_e(:, i) = R * v_s(:, i);
    end
end 