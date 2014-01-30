% Import data from a text file with ImageExpress Data

function data = getWellSiteNames(folder,filename)

cd(folder);
fileid = fopen(filename);

data = textscan(fileid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s', 'delimiter', ',');     