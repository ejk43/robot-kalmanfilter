function [ validname ] = getValidFilename( filename )
%GETVALIDFILENAME gets a valid file name

validname = filename;
idx = 1;
while exist(validname, 'file')
    [path, name, ext] = fileparts(validname);
    validname = [path '\' name '_' num2str(idx) ext];
    idx = idx + 1;
end

end

