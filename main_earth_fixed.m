%% imports
addpath("utils")
addpath("transforms")

%% data
close all
clc

set(groot,'defaultAxesFontSize', 14)
set(groot, 'defaultLineLineWidth', 2)

% CONSTANTS
r_earth = 6371;                         % radius of earth [km]
om_earth = 2*pi/86164;                  % angular velocity of earth [rad/s]
GM = 398.6005 * 1e12;                   % gravitational constant times mass of earth

T_earth = 1/(om_earth/2/pi);            % revolution period of earth [rad/s]
a_gs = ((T_earth/pi/2).^2*GM).^(1/3);   % geostationary semi-major axis [m]


% SETTINGS & ORBIT PARAMETERS
from_perigee = false;                    % whether to ignore perigee passing time
% TODO: find from_perigee bug

names = ["GOCE", "GPS", "Molniya", "GEO", "Michibiki"];
colors = ["blue", "cyan", "green", "red", "magenta"];
params = [
    6629, .004, 96.6, 210, 144.2, str2seconds("20:00");
    26560, .01, 55, 30, 30, str2seconds("00:30");
    26554, .7, 63, 200, 270, str2seconds("03:30");
    a_gs/1000, 0, 0, 0, 50, str2seconds("23:00");
    a_gs/1000, .075, 41, 200, 270, str2seconds("18:30")
    ];

% indices = [1,2];
% names = names(indices);
% colors = colors(indices);
% prams = params(indices, :);

%%  B6) & B7) orbits in earth fixed reference system & B8) ground tracks
%   B9) & B10) Topocentric system (Wettzell)

theta0 = HA2rad(3, 32, 0);
t0_str = "Nov. 14, 2022, 00:00 UT";
n_revolutions = 2;
n_goce = 2;

show_direction_skyplot = false;


r_wettzell = [4075.53022, 931.78130, 4801.61819]' .* 1e3;

figure(5)
title("Orbits in Earth-Fixed Coordinate System")
xlabel("x [m]")
ylabel("y [m]")
zlabel("z [m]")
hold on
axis equal
Earth_coast(3)

figure(6)
title(sprintf("Ground Tracks (%d revolutions)", n_revolutions))
xlabel("longitude [°]")
ylabel("latitude [°]")
hold on
axis equal
Earth_coast(2)

figure(7)
title("Longitude over Time")
xlabel("t [h]")
ylabel("longitude [deg]")
hold on


figure(8)
% sp = skyplot([], []);
sp = skyplot(0,0);
sp.MarkerSize = 1e-10;
title("Skyplot for Wettzell - " + t0_str)
hold on

figure(9)
hold on
sgtitle("Visibility over Wettzell")

% t_h = 0:.01:24;
% t_s = 3600*t_h;
for i=1:length(names)
    disp(names(i));
    curr_params = params(i, :);

    a = curr_params(1);
    ecc = curr_params(2);
    incl = curr_params(3);
    raan = curr_params(4);
    aop = curr_params(5);
    T0 = curr_params(6);

    n = sqrt(GM/((a*1000)^3));
    T_h = 2*pi/n / 3600;

    rev_ratio = n/om_earth;
    fprintf("\tratio n/om_earth %f\n", rev_ratio)

    if names(i) == "GOCE"
        t_step = 0.01;
        t_h = 0:t_step:ceil(n_goce*T_h);
        t_s = 3600*t_h;
    else
        t_step = 0.01;
        t_h = 0:t_step:ceil(n_revolutions*T_h);
        t_s = 3600*t_h;
    end
    

    [r, v] = kep2cart(t_s, a, ecc, incl, raan, aop, T0, from_perigee);

    [r_e, v_e] = cart2efix(t_s, r, v, theta0);
    x = r_e(1, :);
    y = r_e(2, :);
    z = r_e(3, :);

    % vis 3D
    figure(5)
    if names(i) == "GEO"
        scatter3(x, y, z, 100, colors(i), "*", DisplayName=names(i))
    else
        plot3(x, y, z, DisplayName=names(i), Color=colors(i))
    end

    % vis GT
    figure(6)
    lng = rad2deg(atan2(y, x));
    lat = rad2deg(atan2(z, sqrt(x.^2 + y.^2)));

    legend_entry = names(i) + sprintf(" [%d-%d]h", t_h(1), t_h(end));
    if names(i) == "GEO"
        scatter(lng, lat, 100, colors(i), "*", DisplayName=legend_entry)
    else
        scatter(lng, lat, 20, colors(i), HandleVisibility='off')
        plot_ground_tracks(lng, lat, 6, colors(i), legend_entry) 
    end
    
    % longitude over time
    figure(7)
    plot(t_h, lng, Color=colors(i), DisplayName=names(i))
    

    % topocentric
    figure(8)

    [r_topo, v_topo, az, elev] = efix2topo(r_e, v_e, r_wettzell);
    az_deg = rad2deg(az);
    elev_deg = rad2deg(elev);
    az_deg(elev_deg < 0) = nan;
    elev_deg(elev_deg < 0) = nan;

    legend_entry = names(i) + sprintf(" [%d-%d]h", t_h(1), t_h(end));
    if names(i) == "GEO"
        sp = skyplot(az_deg, elev_deg, "x"+colors(i), false, legend_entry);
        sp.MarkerSize = 10;
    else
        sp = skyplot(az_deg, elev_deg, "+"+colors(i), show_direction_skyplot, legend_entry);
        sp.MarkerSize = 1;
    end

    % visibility
    figure(9)
    subplot(size(params, 1), 1, i)
    hold on
    title(names(i))

    vis = int8(elev > 1e-10);
    
    area(t_h, vis, FaceColor=colors(i), EdgeColor=colors(i))
    xlim([t_h(1), t_h(end)])
    ylim([0, 1])
    set(gca, 'YTick', 0:1)

end

figure(5)
legend('Location','NorthWest')
campos(1e8 .* [-6.3167   -4.2039    2.6350])

figure(6)
legend('Location','NorthWest')

figure(7)
legend

figure(8)
legend


fig = figure(9);
han=axes(fig,'visible','off');
han.Title.Visible='on';
han.Subtitle.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'visibility');
xlabel(han,'t [h]');
