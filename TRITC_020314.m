% Aggregates and plots mCherry-nuclear localization signal data measured via the TRITC channel 
% This data captures context information for each well within a 96-well plate: total number of
% neurons in the well, the distribution of individual neuron's mCherry intensity (which 
% is a proxy for virus infectivity), and the distribution of individual neuron soma size 
% (which is a proxy for cell culture health). 
% written by Louise R. Giam, giam@stanford.edu, 2012-2014

folder = '/Users/louise/Desktop/020314/6882/';
run_num = '6882';
cd(folder);

% Sets up a cell named "wells" with column titles for individual well data input
fid = fopen('wellnames.txt');
well_data = textscan(fid, '%s');
<<<<<<< HEAD
wells = [0; well_data{1,1}];
wells{1,2} = '# neurons';
wells{1,3} = 'min neuron area';
wells{1,4} = 'mean neuron area';
wells{1,5} = 'max neuron area';
wells{1,6} = 'min intensity';
wells{1,7} = 'mean intensity';
wells{1,8} = 'max intensity';
wells{1,9} = 'SD intensity';
wells{1,10} = 'SD neuron area';
 
% Fills in individual well data by invoking the function "calc_well" 
for i = 1:1:(size(wells,1)-1)
   [num_neurons, area_min, area_mean, area_max, ...
       int_min, int_mean, int_max, int_sd, area_sd] = ...
       calc_well(wells{i+1,1}); 
   wells{i+1,2} = num_neurons;
   wells{i+1,3} = area_min;
   wells{i+1,4} = area_mean;
   wells{i+1,5} = area_max;
   wells{i+1,6} = int_min;
   wells{i+1,7} = int_mean;
   wells{i+1,8} = int_max;
   wells{i+1,9} = int_sd;
   wells{i+1,10} = area_sd;
=======
well_names = [0; well_data{1,1}];
%creating a title for each column
well_names{1,2} = '# neurons';
well_names{1,3} = 'min neuron area';
well_names{1,4} = 'mean neuron area';
well_names{1,5} = 'max neuron area';
well_names{1,6} = 'min intensity';
well_names{1,7} = 'mean intensity';
well_names{1,8} = 'max intensity';
well_names{1,9} = 'SD intensity';
well_names{1,10} = 'SD neuron area';

for i = 1:1:(size(well_names,1)-1)
   [num_neurons, area_min, area_mean, area_max, ...
       int_min, int_mean, int_max, int_sd, area_sd] = ...
       calc_well(well_names{i+1,1});
%filling in the rest of the row with data
   well_names{i+1,2} = num_neurons;
   well_names{i+1,3} = area_min;
   well_names{i+1,4} = area_mean;
   well_names{i+1,5} = area_max;
   well_names{i+1,6} = int_min;
   well_names{i+1,7} = int_mean;
   well_names{i+1,8} = int_max;
   well_names{i+1,9} = int_sd;
   well_names{i+1,10} = area_sd;
>>>>>>> 711233a68af9239745ab703e6651479b8e8cb705
end

% Saves the aggregated cell data  
tritcSummary = wells;
save([run_num '-tritcSummary'], 'tritcSummary');
 
% Generates a figure with 3 plots: (A) # neurons, (B) neuron intensities, (C) neuron areas
size_wells = size(wells,1);
well_labels = [wells(2:size_wells,1)];
figure; 

% (A) Plots the total number of neurons in a bar graph
subplot(3,1,1)
hold on
title({folder; ' '; 'total number of neurons'});
 
bar([wells{2:size_wells,2}],'k');
xlim([0 size_wells]);
ylim([0 6000]);
set(gca,'XTickLabel', well_labels, 'XTick', [1:1:size_wells]);
ylabel('# neurons');
  
% (B) Plot individual neuron TRITC intensities with error bars
subplot(3,1,2)
hold on
title({folder; ' '; 'neuron TRITC intensity'});
 
errorbar([wells{2:size_wells,7}],[wells{2:size_wells,9}],'xk');
xlim([0 size_wells]);
ylim([0 900]);
set(gca,'XTickLabel', well_labels, 'XTick', [1:1:size_wells]);
ylabel('intensity (a.u.)');
 
% (C) Plot the mean soma areas with error bars
subplot(3,1,3)
hold on
title({folder; ' '; 'mean neuron areas'});
 
errorbar([wells{2:size_wells,4}],[wells{2:size_wells,10}],'xk');
xlim([0 size_wells]);
ylim([0 250]);
set(gca,'XTickLabel', well_labels, 'XTick', [1:1:size_wells]);
ylabel('area (pixels)');
