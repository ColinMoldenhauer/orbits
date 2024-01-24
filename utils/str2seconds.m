function s = str2seconds(str)
    tokens = regexp(str, '(\d{2}):(\d{2})', 'tokens');
    matches = tokens{1};
    h_and_min = str2num(join(matches, ' '));
    s = h_and_min(1)*3600 + h_and_min(2)*60;
end