function rad = HA2rad(h, min, s)
    rad = (h/24 + min/24/60 + s/24/3600)*(2*pi);
end