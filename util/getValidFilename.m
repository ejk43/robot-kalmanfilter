function [ validname ] = getValidFilename( filename )
%GETVALIDFILENAME gets a valid file name

[path, name, ext] = fileparts(filename);
validname = filename;
idx = 1;
while exist(validname, 'file')
    validname = [path '\' name '_' num2str(idx) ext];
    idx = idx + 1;
end

end

