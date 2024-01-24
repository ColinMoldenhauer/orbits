function R = R_i(alph, i)
    R = zeros(3);
    R(i, i) = 1;
    
    coord1 = max(mod(i+1, 4), 1);
    coord2 = max(mod(coord1 + 1, 4), 1);

    R(coord1, coord2) = sin(alph);
    R(coord2, coord1) = -sin(alph);

    R(coord1, coord1) = cos(alph);
    R(coord2, coord2) = cos(alph);
end