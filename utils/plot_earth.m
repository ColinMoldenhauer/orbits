function plot_earth(r_earth, filename)
    [img, ~, alpha] = imread(filename);
    imagesc([-r_earth, r_earth], [-r_earth, r_earth], img, 'alphadata', im2double(alpha))
end