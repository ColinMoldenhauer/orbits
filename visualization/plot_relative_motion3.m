function plot_relative_motion3(r, titl, cpos)
    %{

    Plots the relative motion of one satellite w.r.t to another in a 3D plot.
    Best used for relative position vectors given in RSW frame of the central
    satellite.

    param r: relative position vector | size (N, 3)

    param titl: title to plot
    param cpos: camera position to set
    
    %}
    figure
    hold on
    grid on
    title(titl)
    plot3(0, 0, 0, "Or", DisplayName="TerraSAR")
    xlabel("x [m]")
    ylabel("y [m]")
    zlabel("z [m]")
    campos(cpos)
    plot3(r(: , 1), r(:, 2), r(:, 3), LineWidth=1);
    
    % plot projections
    % yz plane
    xL = xlim;
    plot3(xL(2)*ones(size(r(:,1))), r(:, 2), r(:, 3), "b")
    % xz plane
    yL = ylim;
    plot3(r(:, 1), yL(2)*ones(size(r(:,1))), r(:, 3), "b")
    % xy plane
    zL = zlim;
    plot3(r(:, 1), r(:, 2), zL(1)*ones(size(r(:,1))), "b")
    legend(["TerraSAR", "Tandem-X"])
    xlim(xL)
    ylim(yL)
    zlim(zL)
end