function [] = mat2csv(filepath)
%MAT2CSV Converts a .mat file to a .csv file
%
% Converts a .mat file containing vector shaped data fields into a .csv file. 
% Reads data from filename.mat, converts data to cell array and writes cell array to filename.csv within same directory.
% If filename.csv exists it will be overwritten, otherwise a new filename.csv file will be created. 
%
% Arguments:
%   filepath  -  full filepath of .mat file (e.g. "/home/user1/data.mat")
%
% Returns:
%   nothing
%
% Usage example:
%   mat2csv("D:/files/matlab/price_data.mat");
%   mat2csv("/home/user1/data.mat");
%   mat2csv(dir + filename);
%   mat2csv(fullfile("D:/files/matlab", "price_data" + ".mat"));
%
% Copyright (c) 2022, Joshua Bauske
%

    data = load(filepath);                              % Load .mat file as struct 

    [filepath,filename,~] = fileparts(filepath);        % Seperate full filepath into parts

    fields = transpose(fieldnames(data));               % Get struct field names (= csv header names) as cell array  
    lens = zeros(1,length(fields));                     % Allocate space for lengths of data fields
    max_len = length(data.(fields{1}));         
    len_eq = true;
    for j=1:length(fields)
        assert(min(size(data.(fields{j})))==1 && length(size(data.(fields{j})))<=2, ...
            "File %s.mat contains data fields with non vector shaped data.", filename)
        lens(j) = length(data.(fields{j}));                         % Get length of field
        if lens(j) ~= max_len
            max_len = max(max_len,lens(j));                         % Get max length of all fields
            len_eq = false;
        end
        if size(data.(fields{j}),2) > 1
            data.(fields{j}) = data.(fields{j})';                   % Make all struct fields Column Vector Shape
        end
        if ~iscell(data.(fields{j}))
            data.(fields{j}) = num2cell(data.(fields{j}));          % Convert all struct fields to cell array datatype (struct of cell arrays)
        end
        data.(fields{j}) = vertcat(fields{j}, data.(fields{j}));    % Append header names to data fields
    end

    if len_eq == false
        for j=1:length(fields)
            if lens(j) < max_len 
                %data.(fields{j}) = vertcat(data.(fields{j}), num2cell(NaN(max_len-lens(j)-1,1)));      % Extend shorter data fields with NaN values
                data.(fields{j}) = vertcat(data.(fields{j}), cell(max_len-lens(j),1));                % Extend shorter data fields with empty values
            end
        end
    end

    data = (struct2cell(data));     % Convert struct to cell array (column vector shaped with nested cell arrays (=data fields) as entrys)
    data = horzcat(data{:});        % Unfold nested cell arrays to single cell array (matrix shaped: each column represents a data field)

    filepath = fullfile(filepath, filename + ".csv");           % Get full filepath of .csv file
    writecell(data,filepath, "Delimiter", ",");                 % Write to .csv file
    %fprintf("%s successfully processed\n",filename+".mat");     % Optional: print status  
end
