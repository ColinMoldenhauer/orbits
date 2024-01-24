function deg = HA2deg(h, min, s)
    deg = (h/24 + min/24/60 + s/24/3600)*360;
end