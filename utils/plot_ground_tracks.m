function plot_ground_tracks(lng, lat, n_figure, color, legend_entry)
    max_diff = 2*180 - 50;
    diffs = abs(lng(2:end) - lng(1:end-1));
    jump = diffs > max_diff;
    jump_idxs = find(jump);

    figure(n_figure)
    prev_idx = 0;
    for i_jump=1:length(jump_idxs)
        lng_piece = lng(prev_idx+1:jump_idxs(i_jump));
        lat_piece = lat(prev_idx+1:jump_idxs(i_jump));
        plot(lng_piece, lat_piece, Color=color, LineWidth=1, DisplayName=legend_entry, HandleVisibility="off")
        prev_idx = jump_idxs(i_jump);
    end
    % plot final piece
    lng_piece = lng(prev_idx+1:end);
    lat_piece = lat(prev_idx+1:end);
    plot(lng_piece, lat_piece, Color=color, LineWidth=1, DisplayName=legend_entry)
end