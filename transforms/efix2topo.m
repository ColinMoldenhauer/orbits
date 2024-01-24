function [r_topo, v_topo, az, elev] = efix2topo(r_efix, v_efix, r_pos)
    % INPUTS
    %   r_efix    position vector in earth fixed system [m]
    %   v_efix    velocity vector in earth fixed system [m/s]
    %   r_pos     position vector of ground position in earth fixed system [m]
    % OUTPUTS
    %   r_topo    position vector in topocentric system [m]
    %   v_topo    velocity vector in topocentric system [m/s]
    %   az        satellite azimuth [rad]
    %   elev      satellite elevation [rad]

    r_trans = r_efix - r_pos;
    Q1 = diag([-1, 1, 1]);
 
    % ellipsoidal lon lat
    a = 6378*1000;  % equatorial radius
    b = 6357*1000;  % polar radius
    e = sqrt(a^2-b^2)/a;
    e_prime = sqrt(a^2-b^2)/b;
    p = sqrt(r_pos(1)^2 + r_pos(2)^2);
    my = atan2(r_pos(3)*a, p*b);

    lng = atan2(r_pos(2), r_pos(1));
    lat_old = atan2(r_pos(3), sqrt(r_pos(1)^2+r_pos(2)^2));
    lat = atan2(r_pos(3)+e_prime^2*b*sin(my)^3, p-e^2*a*cos(my)^3);

    % rotation matrices
    R2 = R_i(pi/2 - lat, 2);
    R3 = R_i(lng, 3);

    r_topo = zeros(size(r_efix));
    v_topo = zeros(size(r_efix));
    for i=1:size(r_trans, 2)
        r_topo(:, i) = Q1 * R2 * R3 * r_trans(:, i);
        v_topo(:, i) = Q1 * R2 * R3 * v_efix(:, i);
    end

    az = atan2(r_topo(2, :), r_topo(1, :));
    elev = atan2(r_topo(3, :), sqrt(r_topo(1, :).^2 + r_topo(2, :).^2));
end