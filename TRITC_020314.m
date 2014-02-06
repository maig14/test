%% Calculates number of neurons and distribution of areas
folder = '/Users/louise/Desktop/020314/6882/';
cd(folder);
run_num = '6882';
fid = fopen('wellnames.txt');
well_data = textscan(fid, '%s');
well_names = [0; well_data{1,1}];
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
   well_names{i+1,2} = num_neurons;
   well_names{i+1,3} = area_min;
   well_names{i+1,4} = area_mean;
   well_names{i+1,5} = area_max;
   well_names{i+1,6} = int_min;
   well_names{i+1,7} = int_mean;
   well_names{i+1,8} = int_max;
   well_names{i+1,9} = int_sd;
   well_names{i+1,10} = area_sd;
end
 
tritcSummary = well_names;
save([run_num '-tritcSummary'], 'tritcSummary');
 
%% Plots # neurons in bar graphs
 
figure; 
subplot(3,1,1)
hold on
title({folder; ' '; '# total neurons'});
 
size_well_names = size(well_names,1);
well_labels = [well_names(2:size_well_names,1)];
bar([well_names{2:size_well_names,2}],'k');
ylabel('# neurons');
xlim([0 size_well_names]);
ylim([0 6000]);
set(gca,'XTickLabel', well_labels, 'XTick', [1:1:size_well_names]);
 
%subplot(2,1,2)
%hold on
%bar([well_names{32:61,2}],'k');
%ylabel('# neurons');
%xlim([0 31]);
%ylim([0 8000]);
%set(gca,'XTickLabel', well_labels(31:60), 'XTick', [1:1:30]);
%set(gcf, 'Position', [1, 1, 1200, 500]);
 
% Plot total neuron intensities
%figure; 
subplot(3,1,2)
hold on
title({folder; ' '; 'neuron TRITC intensity'});
 
size_well_names = size(well_names,1);
well_labels = [well_names(2:size_well_names,1)];
errorbar([well_names{2:size_well_names,7}],[well_names{2:size_well_names,9}],'xk');
ylabel('intensity (a.u.)');
xlim([0 size_well_names]);
ylim([0 900]);
set(gca,'XTickLabel', well_labels, 'XTick', [1:1:size_well_names]);
 
%subplot(2,1,2)
%hold on
%errorbar([well_names{32:61,7}],[well_names{32:61,9}],'xk');
%ylabel('intensity (a.u.)');
%xlim([0 31]);
%ylim([0 700]);
%set(gca,'XTickLabel', well_labels(31:60), 'XTick', [1:1:30]);
%set(gcf, 'Position', [1, 1, 1200, 500]);
 
    %Plot neuron areas
%figure; 
subplot(3,1,3)
hold on
title({folder; ' '; 'mean neuron areas'});
 
size_well_names = size(well_names,1);
well_labels = [well_names(2:size_well_names,1)];
%bar([well_names{2:31,4}],'k');
errorbar([well_names{2:size_well_names,4}],[well_names{2:size_well_names,10}],'xk');
 
ylabel('area (pixels)');
xlim([0 size_well_names]);
ylim([0 250]);
set(gca,'XTickLabel', well_labels, 'XTick', [1:1:size_well_names]);
 
%subplot(2,1,2)
%hold on
%bar([well_names{32:61,4}],'k');
%errorbar([well_names{32:61,4}],[well_names{32:61,10}],'xk');
 
%ylabel('area (pixels)');
%xlim([0 31]);
%ylim([0 150]);
%set(gca,'XTickLabel', well_labels(31:60), 'XTick', [1:1:30]);
%set(gcf, 'Position', [1, 1, 1200, 500]);
