% Usage example of function mat2csv. 
% Creates two .mat files in working directory and converts afterwards all .mat files within working dir.

clc
clear all
close all

%% Create .mat files
doubles = sin(0:99);
text = strings(1,50);
text(:) = "abcdefg";
CELL = horzcat(num2cell(doubles(1:35)), num2cell(text(1:35)))';
chars = convertStringsToChars(text);

save("example1.mat");
save("example2.mat", "doubles", "CELL");

%% Convert all .mat files to .csv files
input_dir = pwd;
files_info = dir(fullfile(input_dir, "*.mat"));                     % Get info of all .mat files in input_dir as struct

for i = 1:length(files_info)                                        % Loop all files in input_dir
    mat2csv(fullfile(input_dir, files_info(i).name));
end
