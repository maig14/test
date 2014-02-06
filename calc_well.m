function [num_neurons, area_min, area_mean, area_max,...
    intensity_min, intensity_mean, intensity_max, ...
    intensity_sd, area_sd] = calc_well(file_name)
file = [file_name '.txt'];
fileid = fopen(file);

data = textscan(fileid, '%s %d %s %d %f %d %f', 'delimiter', ',');

tritc_area = [data{1,5}];
num_neurons = size(tritc_area, 1);
area_min = min(tritc_area);
area_mean = mean(tritc_area);
area_max = max(tritc_area);
area_sd = std(tritc_area);

intensity = [data{1,7}];
intensity_min = min(intensity);
intensity_mean = mean(intensity);
intensity_max = max(intensity);
intensity_sd = std(intensity);
