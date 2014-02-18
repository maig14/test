% This Matlab function opens a text file (file_name.txt) and imports comma-delimited data in 
% a certain format. This function can be modified as needed to suit the text file format. 

% In this case, the text file contains data generated from Molecular Devices ImageXpress 
% from one fluorescence channel (TRITC), which designates the neuronal mCherry-nuclear 
% localization signal. Data was collected for numerous neurons in multiple sites within 
% wells of a 96-well plate.   
 
% The comma-delimited data is formatted with this information: Image Name, Image Plane, 
% Stage Label, Cell: Assigned Label #, Cell: Area, Cell: Integrated Intensity, Cell: 
% Average Intensity.

% In Matlab, %s denotes string, %d denotes integer, and %f denotes floating point. An 
% example of one line in the text file that is being imported: 
% "TRITC-FIXED", 1, "B02: Site 2", 5, 48.2589, 5328, 183.724 
 
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
