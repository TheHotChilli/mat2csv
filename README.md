# mat2csv
A MATLAB function for converting *.mat* files to *.csv* files. 


### Description:
This function reads data from a *filename.mat* file, converts the data to one cell array and writes the cell array to a *filename.csv* file within same directory.
If *filename.csv* exists it will be overwritten, otherwise a new *filename.csv* file will be created. 
### Usage Example:
    mat2csv("/home/user/data/measurement01.mat");
### Notes:
- Data fields within .mat file need to be vector shaped.
- Can handle mixed types of data within the .mat file due to cell conversion.
- Cell conversion and writing cell arrays takes time, especially for large files! There might be faster solutions - e.g. if the .mat file only contains numerical data.   
