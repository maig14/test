% Import data from a text file with ImageExpress Data

function data = getRealData(folder,filename)

cd(folder);
fileid = fopen(filename);

data = textscan(fileid, '%s %d %s %s %s %d %f %d %f %d %f %f %f %d %f %f %f', 'delimiter', ',');     