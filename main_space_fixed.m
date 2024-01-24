%% imports
addpath("utils")
addpath("transforms")

%% data
close all
clc

set(groot, 'defaultAxesFontSize', 14)
set(groot, 'defaultLineLineWidth', 2)

% CONSTANTS
r_earth = 6371;                         % radius of earth [km]
om_earth = 2*pi/86164;                  % angular velocity of earth [rad/s]
GM = 398.6005 * 1e12;                   % gravitational constant times mass of earth

T_earth = 1/(om_earth/2/pi);            % revolution period of earth [rad/s]
a_gs = ((T_earth/pi/2).^2*GM).^(1/3);   % geostationary semi-major axis [m]


% SETTINGS & ORBIT PARAMETERS
from_perigee = true;                    % whether to consider perigee passing time

names = ["GOCE", "GPS", "Molniya", "GEO", "Michibiki"];
colors = ["blue", "cyan", "green", "red", "magenta"];
params = [
    6629, .004, 96.6, 210, 144.2, str2seconds("20:00");
    26560, .01, 55, 30, 30, str2seconds("00:30");
    26554, .7, 63, 200, 270, str2seconds("03:30");
    a_gs/1000, 0, 0, 0, 50, str2seconds("23:00");
    a_gs/1000, .075, 41, 200, 270, str2seconds("18:30")
    ];

%%  A1) & A2) visualize orbits
%   A3) time-dependent nu, r, M, E

n_revolutions_2D = 1;
n_revolutions = 2;

figure(1)
title(sprintf("Orbits in orbital plane for %d revolution", n_revolutions_2D))
axis("equal")
hold on

plot_earth(r_earth, 'misc/earth.png');

figure(21)
sgtitle("{\itM}, {\itE}, \nu over time of 5 satellites " + sprintf("for %d revolutions", n_revolutions))
hold on

for i=1:length(names)
    disp(names(i))
    figure(21)
    subplot(2,3,i)
    hold on
    set(gca, 'DefaultLineLineWidth', 2)
    xlabel("t [h]")
    ylabel("[deg]")

    curr_params = params(i, :);

    a = curr_params(1);
    ecc = curr_params(2);
    incl = curr_params(3);
    raan = curr_params(4);
    aop = curr_params(5);
    T0 = curr_params(6);
    
    % A1
    % time vector for n_rev_2D revolutions
    n = sqrt(GM/((a*1000)^3));
    T_h = 2*pi/n / 3600;
    t_h = 0:.1:n_revolutions_2D*T_h;
    t_s = 3600*t_h;

    [r, nu, M, E] = kep2orb(t_s, a, ecc, T0, true);
    r = r/1000;

    % vis A1
    figure(1)
    x = r .* cos(nu);
    y = r .* sin(nu);
    scatter(x, y, 14, colors(i), DisplayName=names(i));
    
    % A3
    % time vector for n_rev revolutions
    n = sqrt(GM/((a*1000)^3));
    T_h = 2*pi/n / 3600;
    t_h = 0:.1:n_revolutions*T_h;
%     t_h = 0:.1:12;
    t_s = 3600*t_h;

    [r, nu, M, E] = kep2orb(t_s, a, ecc, T0, true);
    r = r/1000;
    
    % vis A3
    figure(21)
    title(names(i))
    plot(t_h, rad2deg(M), DisplayName="M", Color="blue")
    plot(t_h, rad2deg(E), DisplayName="E", Color="green")
    plot(t_h, rad2deg(nu), DisplayName="\nu", Color="red")
    plot(t_h, rad2deg(nu-M), DisplayName="\nu-M", Color="cyan")
    legend('Location','NorthWest')
end

% only GPS, Molniya
figure(22)
sgtitle("{\itM}, {\itE}, \nu over time of GPS and Molniya " + sprintf("for %d revolutions", n_revolutions))
hold on
selected_idxs = [2,3];
for j=1:length(selected_idxs)
    i = selected_idxs(j);
    subplot(1,2,j)
    hold on
    set(gca, 'DefaultLineLineWidth', 2)
    xlabel("t [h]")
    ylabel("[deg]")

    curr_params = params(i, :);

    a = curr_params(1);
    ecc = curr_params(2);
    incl = curr_params(3);
    raan = curr_params(4);
    aop = curr_params(5);
    T0 = curr_params(6);

    % time vector for n_rev revolutions
    n = sqrt(GM/((a*1000)^3));
    T_h = 2*pi/n / 3600;
    t_h = 0:.01:ceil(n_revolutions*T_h);
    t_s = 3600*t_h;

    [r, nu, M, E] = kep2orb(t_s, a, ecc, T0, from_perigee);
    
    % vis
    title(names(i))
    plot(t_h, rad2deg(M), DisplayName="M", Color="blue")
    plot(t_h, rad2deg(E), DisplayName="E", Color="green")
    plot(t_h, rad2deg(nu), DisplayName="\nu", Color="red")
    plot(t_h, rad2deg(nu-M), DisplayName="\nu-M", Color="cyan")
    legend('Location','NorthWest')
end

figure(1)
legend
xlabel("x [km]")
ylabel("y [km]")
%% A4) & A5) position, velocity from Keplerian elements
set(groot,'defaultLineLineWidth',2)

figure(4)
sgtitle("Orbits in Planes of Cartesian Space-Fixed System and Satellite Velocity")
titles_planes = ["XY", "XZ", "YZ"] + " plane";
for i_plot=1:3
    subplot(220+i_plot)
    hold on
    axis equal
    as_char = char(titles_planes(i_plot));
    title(titles_planes(i_plot))
    xlabel(sprintf('%c [m]', lower(as_char(1))))
    ylabel(sprintf('%c [m]', lower(as_char(2))))
end

figure(3)
title("Orbits in Cartesian Space-Fixed System")
hold on
axis equal

Earth_coast(3)

t_h = 0:.01:24;
t_s = 3600*t_h;
for i=1:length(names)
    curr_params = params(i, :);

    a = curr_params(1);
    ecc = curr_params(2);
    incl = curr_params(3);
    raan = curr_params(4);
    aop = curr_params(5);
    T0 = curr_params(6);

    [r, v] = kep2cart(t_s, a, ecc, incl, raan, aop, T0, from_perigee);
    
    % vis 3D
    figure(3)
    plot3(r(1, :), r(2, :), r(3, :), DisplayName=names(i), Color=colors(i))

    figure(4)
    subplot(221)
    plot(r(1,:), r(2,:), Color=colors(i))
    subplot(222)
    plot(r(1,:), r(3,:), Color=colors(i))
    subplot(223)
    plot(r(2,:), r(3,:), Color=colors(i))
    subplot(224)
    hold on
    plot(t_h, vecnorm(v,2,1), Color=colors(i))
end
figure(3)
legend('Location','NorthWest')

xlabel("x [m]")
ylabel("y [m]")
zlabel("z [m]")
campos(1e8 .* [-6.3167   -4.2039    2.6350])

% vis 2D
figure(4)
subplot(224)
title('Magnitude of velocity with time')
xlabel("t [h]")
ylabel("velocity [m/s]")

