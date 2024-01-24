function plot_xyz_components(x, t_h, titl, y_labl)
% Plots the three components of a vector over time in separate subplots.
%
%   x:          data to plot          size (N, 3)
%   t_h:        time vector [h]       size (1, N)
%   titl:       title to plot
%   y_labl:     y-label to plot

    fig = figure;
    hold on
    sgt = sgtitle(titl);
    sgt.FontWeight = "bold";
    sgt.FontSize = 20;
    subplot(3, 1, 1)
    hold on
    title("x-component")
    plot(t_h, x(:, 1))
    subplot(3, 1, 2)
    hold on
    title("y-component")
    plot(t_h, x(:, 2))
    subplot(3, 1, 3)
    hold on
    title("z-component")
    plot(t_h, x(:, 3))

    han=axes(fig,'visible','off');
    han.Title.Visible='on';
    han.Subtitle.Visible='on';
    han.XLabel.Visible='on';
    han.YLabel.Visible='on';
    ylab_pos = han.YLabel.Position;
    han.YLabel.Position=ylab_pos;
    ylabel(han, y_labl);
    xlabel(han,'time [h]');
end