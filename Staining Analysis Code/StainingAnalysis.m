%% Secondary Staining Analysis Matlab Program
% For staining data from imageExpress exports.

% Author: Anna McGregor
% Date: 8/29/13

% 5 "Well Name : Site Number"
% 8 "Cell: Assigned Label #"
% 9 "Cell: Total Outgrowth" 
% 10 "Cell: Processes" 
% 11 "Cell: Mean Process Length" 
% 13 "Cell: Max Process Length"
% 14 "Cell: Branches" 
% 16 "Cell: Cell Body Area"
% 17 "Cell: Mean Outgrowth Intensity"

%% Import Data

clear all
close all

% FILE NAME CAN BE ENTERED BELOW, or when the program prompts you to enter
% it. Data must have the titles added by imageExpress removed (ie., the
% columns listed above labeled 5-17), but no other data simplification is
% required.
filename = '';
if isempty(filename)
    filename = input('What is the title of the text file you want to import (exclude .txt): ','s');
end
file = strcat(filename,'.txt');

% FILE LOCATIONS CAN BE EDITED HERE. Otherwise, the program will assume
% that the file is in the 'NeuroDataAnalysis' folder on the desktop.
cd('/Users/agmcgregor/Desktop/NeuroDataAnalysis/');
WellData = getRealData('/Users/agmcgregor/Desktop/NeuroDataAnalysis/',file);
siteNames = getWellSiteNames('/Users/agmcgregor/Desktop/NeuroDataAnalysis/','WellSiteNames.txt');

%% Initialize Variables
wellNames = ['B02';'B03';'B04';'B05';'B06';'B07';'B08';'B09';'B10';'B11';'C02';'C03';'C04';'C05';'C06';'C07';'C08';'C09';'C10';'C11';'D02';'D03';'D04';'D05';'D06';'D07';'D08';'D09';'D10';'D11';'E02';'E03';'E04';'E05';'E06';'E07';'E08';'E09';'E10';'E11';'F02';'F03';'F04';'F05';'F06';'F07';'F08';'F09';'F10';'F11';'G02';'G03';'G04';'G05';'G06';'G07';'G08';'G09';'G10';'G11'];
currentSite = 1;
nextSite = 2;
currentWell = 1;
nextWell = 2;

growth = zeros(60,1);

numNeurons = zeros(60,35);
numNeuronsPerWell = zeros(60,1);

processesPerSite = zeros(60,35);
processesPerWell = zeros(60,1);

branchesPerSite = zeros(60,35);
branchesPerWell = zeros(60,1);

totalBodyAreaPerSite = zeros(60,35);
totalBodyAreaPerWell = zeros(60,1);

meanIntensityPerSite = zeros(60,35);
meanIntensityPerWell = zeros(60,1);

totalMeanProcessLengthPerSite = zeros(60,35);
totalMeanProcessLengthPerWell = zeros(60,1);

maxProcessLengthPerSite = zeros(60,35);
maxProcessLengthPerWell = zeros(60,1);

%% Examine and analyze data
for i=1:size(WellData{1,5},1)
    if (currentWell == 61)
        break
    % check and see if we are still on the current site and well
    elseif strcmp(WellData{1,5}{i,1}, siteNames{1,currentSite}{currentWell,1})
        
        growth(currentWell,1) = growth(currentWell,1) + WellData{1,9}(i,1);
        
        numNeuronsPerWell(currentWell,1) = numNeuronsPerWell(currentWell,1) + 1;
        numNeurons(currentWell,currentSite) = numNeurons(currentWell,currentSite) + 1;
        
        processesPerSite(currentWell,currentSite) = processesPerSite(currentWell,currentSite) + WellData{1,10}(i,1);
        
        branchesPerSite(currentWell,currentSite) = branchesPerSite(currentWell,currentSite) + WellData{1,14}(i,1);
        
        totalBodyAreaPerSite(currentWell,currentSite) = totalBodyAreaPerSite(currentWell,currentSite) + WellData{1,16}(i,1);
        
        meanIntensityPerSite(currentWell,currentSite) = meanIntensityPerSite(currentWell,currentSite) + WellData{1,17}(i,1);
        
        totalMeanProcessLengthPerSite(currentWell,currentSite) = totalMeanProcessLengthPerSite(currentWell,currentSite) + WellData{1,11}(i,1);
        
        if maxProcessLengthPerSite(currentWell,currentSite) < WellData{1,13}(i,1)
           maxProcessLengthPerSite(currentWell,currentSite) = WellData{1,13}(i,1); 
        end
    
    % if we are not on the current site+well, check the same well but next
    % site
    elseif strcmp(WellData{1,5}{i,1}, siteNames{1,nextSite}{currentWell,1})
        
        growth(currentWell,1) = growth(currentWell,1) + WellData{1,9}(i,1);
        
        numNeuronsPerWell(currentWell,1) = numNeuronsPerWell(currentWell,1) + 1;
        numNeurons(currentWell,nextSite) = numNeurons(currentWell,nextSite) + 1;
        
        processesPerSite(currentWell,nextSite) = processesPerSite(currentWell,nextSite) + WellData{1,10}(i,1);
        
        branchesPerSite(currentWell,nextSite) = branchesPerSite(currentWell,nextSite) + WellData{1,14}(i,1);
        
        totalBodyAreaPerSite(currentWell,nextSite) = totalBodyAreaPerSite(currentWell,nextSite) + WellData{1,16}(i,1);
        
        meanIntensityPerSite(currentWell,nextSite) = meanIntensityPerSite(currentWell,nextSite) + WellData{1,17}(i,1);
        
        totalMeanProcessLengthPerSite(currentWell,nextSite) = totalMeanProcessLengthPerSite(currentWell,nextSite) + WellData{1,11}(i,1);
        
        if maxProcessLengthPerSite(currentWell,nextSite) < WellData{1,13}(i,1)
           maxProcessLengthPerSite(currentWell,nextSite) = WellData{1,13}(i,1); 
        end
        
        % update sites and wells
        currentSite = nextSite;
        if (nextSite < 35)
            nextSite = nextSite + 1;
        else
            nextSite = 1;
        end
    
    elseif (currentWell == 60)
        % see if we need to skip a site
        if (nextSite < 35)
            nextSite = nextSite + 1;
        else % we are done...
            break;
        end
        
    % check if we are on the next well and next site
    elseif strcmp(WellData{1,5}{i,1}, siteNames{1,nextSite}{nextWell,1})
        
        growth(nextWell,1) = growth(nextWell,1) + WellData{1,9}(i,1);
        
        numNeuronsPerWell(nextWell,1) = numNeuronsPerWell(nextWell,1) + 1;
        numNeurons(nextWell,nextSite) = numNeurons(nextWell,nextSite) + 1;
        
        processesPerSite(nextWell,nextSite) = processesPerSite(nextWell,nextSite) + WellData{1,10}(i,1);
        
        branchesPerSite(nextWell,nextSite) = branchesPerSite(nextWell,nextSite) + WellData{1,14}(i,1);
        
        totalBodyAreaPerSite(nextWell,nextSite) = totalBodyAreaPerSite(nextWell,nextSite) + WellData{1,16}(i,1);
        
        meanIntensityPerSite(nextWell,nextSite) = meanIntensityPerSite(nextWell,nextSite) + WellData{1,17}(i,1);
        
        totalMeanProcessLengthPerSite(nextWell,nextSite) = totalMeanProcessLengthPerSite(nextWell,nextSite) + WellData{1,11}(i,1);
        
        if maxProcessLengthPerSite(nextWell,nextSite) < WellData{1,13}(i,1)
           maxProcessLengthPerSite(nextWell,nextSite) = WellData{1,13}(i,1); 
        end
        
        % update sites and wells
        currentWell = nextWell;
        currentSite = nextSite;
        nextSite = 2;
        nextWell = nextWell + 1;   
    
    % the next site or well is empty/missing
    else
        if (currentSite == 35)
            currentWell = nextWell;
            nextWell = nextWell + 1;
        end
        currentSite = nextSite;
        if (nextSite < 35)
            nextSite = nextSite + 1;
        else
            nextSite = 1;
        end
    end
end

%% Remaining Calculations

% Calculations for total outgrowth
growthPerNeuron = growth./numNeuronsPerWell(:,1);

% Calculations for number of neurons
meanNumNeuronsPerSite = numNeuronsPerWell(:,1)/35;
sigma2neuronsPerSite = zeros(60,1);
for eachSite = 1:35
    sigma2neuronsPerSite = sigma2neuronsPerSite + (numNeurons(:,eachSite) - meanNumNeuronsPerSite(:,1)).^2;
end
sigma2neuronsPerSite = sigma2neuronsPerSite/35;
stddevNeuronsPerSite = sigma2neuronsPerSite .^ 0.5;

% Calculations for processes, branches, cell body area, intensity, and mean
% process length
for i = 1:35
    processesPerWell = processesPerWell + processesPerSite(:,i);
    branchesPerWell = branchesPerWell + branchesPerSite(:,i);
    totalBodyAreaPerWell = totalBodyAreaPerWell + totalBodyAreaPerSite(:,i);
    meanIntensityPerWell = meanIntensityPerWell + meanIntensityPerSite(:,i);
    totalMeanProcessLengthPerWell = totalMeanProcessLengthPerWell + totalMeanProcessLengthPerSite(:,i);
end
avgProcessesPerNeuron = processesPerWell./numNeuronsPerWell;
avgBranchesPerNeuron = branchesPerWell./numNeuronsPerWell;
avgBodyAreaPerNeuron = totalBodyAreaPerWell./numNeuronsPerWell;
avgIntensityPerNeuron = meanIntensityPerWell./numNeuronsPerWell;
meanProcessLengthPerNeuron = totalMeanProcessLengthPerWell./numNeuronsPerWell;

processesPerNeuronSite = processesPerSite./numNeurons;
branchesPerNeuronSite = branchesPerSite./numNeurons;
cellAreaPerNeuronSite = totalBodyAreaPerSite./numNeurons;
meanIntensityPerNeuronSite = meanIntensityPerSite./numNeurons;
meanProcessLengthPerNeuronSite = totalMeanProcessLengthPerSite./numNeurons;

% Calculation for max process length
for i = 1:60
    for j = 1:35
        if maxProcessLengthPerWell(i,1) < maxProcessLengthPerSite(i,j)
            maxProcessLengthPerWell(i,1) = maxProcessLengthPerSite(i,j);
        end
    end
end
%Because the max process length is too big to display well on a graph with
%the mean...
maxProcessLengthPerWell = maxProcessLengthPerWell/10;

%% Display Data
m = 0;
displayData = input('Would you like to see the summary data for the plate? Y/N [Y]: ','s');
if isempty(displayData)
   displayData = 'y'; 
end
if strcmpi(displayData,'y')
    % Display Summary Data
    figure('Name',strcat('Summary of Well Data for:_',filename));
    subplot(5,2,1)
    bar(numNeuronsPerWell(:,1))
    hold on
    title('Total Number of Neurons Per Well')
    xlabel('Well Number')
    xlim([0 61])
    ylabel('Number of Neurons')
    subplot(5,2,3)
    errorbar(meanNumNeuronsPerSite(:,1),stddevNeuronsPerSite(:,1),'ob')
    hold on
    grid on
    title('Average Number of Neurons per Site for Each Well')
    xlabel('Well Number')
    xlim([0 61])
    ylabel('Number of Neurons')
    subplot(5,2,5)
    bar(growthPerNeuron(:,1))
    hold on
    title('Total Outgrowth Per Neuron')
    xlabel('Well Number')
    xlim([0 61])
    ylabel('Outgrowth per Neuron')
    subplot(5,2,7)
    bar(growth(:,1));
    hold on
    title('Total Outgrowth Per Well')
    xlabel('Well Number')
    xlim([0 61])
    ylabel('Outgrowth')
    subplot(5,2,2)
    bar(avgProcessesPerNeuron(:,1))
    hold on
    title('Average Number of Processes Per Neuron in Each Well')
    xlabel('Well Number')
    xlim([0 61])
    ylabel('Processes')    
    subplot(5,2,4)
    bar(avgBranchesPerNeuron(:,1))
    hold on
    title('Average Number of Branches Per Neuron in Each Well')
    xlabel('Well Number')
    xlim([0 61])
    ylabel('Branches') 
    subplot(5,2,6)
    bar(avgBodyAreaPerNeuron(:,1))
    hold on
    title('Average Cell Body Area Per Neuron in Each Well')
    xlabel('Well Number')
    xlim([0 61])
    ylabel('Cell Body Area')
    subplot(5,2,9)
    scatter(avgProcessesPerNeuron(:,1),avgBranchesPerNeuron(:,1),10,'o')
    hold on
    title('Average Processes Per Neuron vs. Average Branches Per Neuron for Each Well')
    xlabel('Processes')
    ylabel('Branches') 
    subplot(5,2,8)
    bar(avgIntensityPerNeuron(:,1))
    hold on
    title('Average Outgrowth Intensity Per Neuron in Each Well')
    xlabel('Well Number')
    xlim([0 61])
    ylabel('Outgrowth Intensity')
    subplot(5,2,10)
    bar(maxProcessLengthPerWell,'r')
    hold on
    bar(meanProcessLengthPerNeuron)
    hold on
    title('Mean and Maximum Process Length Per Neuron in Each Well (Mean = blue, Max = red)')
    xlabel('Well Number')
    xlim([0 61])
    ylabel('Process Length (x10 for Max)')
end

% Ask about saving figure
saveFig = input('Do you want to save this figure? Y/N [N]: ','s');
if strcmpi(saveFig,'Y')
    figTitle = input('Enter a title for the figure: ','s');
    figTitle = strcat(figTitle,'.jpg');
    saveas(gcf,figTitle);
end

% Ask about looking at well-specific data
whichWell = 0;
prompt = 'Would you like to look at a specific well? Y/N [N]: ';
seeSpecWell = input(prompt,'s');
if strcmpi(seeSpecWell,'y')
    prompt = 'Which well would you like to look at? Enter an integer from 1 to 60, or 0 to exit: ';
    whichWell = input(prompt);
end

while ((whichWell <= 60) & (whichWell >= 1))
    % Display well-specific data
    figure('Name','Well-Specific Data')
    subplot(2,2,1)
    bar(numNeurons(whichWell,:))
    hold on
    title(horzcat('Number of Neurons Per Site for Well Number ', num2str(whichWell), ' (' , wellNames(whichWell,:), ')'))
    xlabel('Site Number')
    xlim([0 36])
    ylabel('Number of neurons')
    subplot(2,2,2)
    bar(processesPerNeuronSite(whichWell,:))
    hold on
    title(horzcat('Processes Per Neuron Per Site for Well Number ', num2str(whichWell), ' (' , wellNames(whichWell,:), ')'))
    xlabel('Site Number')
    xlim([0 36])
    ylabel('Number of Processes')
    subplot(2,2,3)
    bar(branchesPerNeuronSite(whichWell,:))
    hold on
    title(horzcat('Branches Per Neuron Per Site for Well Number ', num2str(whichWell), ' (' , wellNames(whichWell,:), ')'))
    xlabel('Site Number')
    xlim([0 36])
    ylabel('Number of Branches')
    subplot(2,2,4)
    bar(cellAreaPerNeuronSite(whichWell,:))
    hold on
    title(horzcat('Cell Body Area Per Neuron Per Site for Well Number ', num2str(whichWell), ' (' , wellNames(whichWell,:), ')'))
    xlabel('Site Number')
    xlim([0 36])
    ylabel('Total Cell Body Area')
    
    % Ask about saving figure
    saveFig = input('Do you want to save this figure? Y/N [N]: ','s');
    if strcmpi(saveFig,'Y')
        figTitle = input('Enter a title for the figure: ','s');
        figTitle = strcat(figTitle,'.jpg');
        saveas(gcf,figTitle);
    end
    
    prompt = 'Would you like to look at another specific well? Y/N [N]: ';
    seeSpecWell = input(prompt,'s');
    if strcmpi(seeSpecWell,'y')
        prompt = 'Which well would you like to look at? Enter an integer from 1 to 60, or 0 to exit: ';
        whichWell = input(prompt);
    else
        whichWell = 0;
    end
end

%% Create Secondary Analysis Summary Data and Save

secondarySummary = cell(61,9);
secondarySummary{1,1} = 'Well Name';
secondarySummary{1,2} = 'Neurons Per Well';
secondarySummary{1,3} = 'Average Neurons Per Site';
secondarySummary{1,4} = 'Standard Deviation of Neurons Per Site';
secondarySummary{1,5} = 'Outgrowth Per Neuron';
secondarySummary{1,6} = 'Average Processes Per Neuron';
secondarySummary{1,7} = 'Average Branches Per Neuron';
secondarySummary{1,8} = 'Average Cell Body Area Per Neuron';
secondarySummary{1,9} = 'Mean Process Length';

for i = 2:61
    secondarySummary{i,1} = strcat(wellNames(i-1,:));
    secondarySummary{i,2} = numNeuronsPerWell(i-1,1);
    secondarySummary{i,3} = meanNumNeuronsPerSite(i-1,1);
    secondarySummary{i,4} = stddevNeuronsPerSite(i-1,1);
    secondarySummary{i,5} = growthPerNeuron(i-1,1);
    secondarySummary{i,6} = avgProcessesPerNeuron(i-1,1);
    secondarySummary{i,7} = avgBranchesPerNeuron(i-1,1);
    secondarySummary{i,8} = avgBodyAreaPerNeuron(i-1,1);
    secondarySummary{i,9} = meanProcessLengthPerNeuron(i-1,1);
end

save(strcat(filename,'_SecondaryAnalysis'),'secondarySummary');


