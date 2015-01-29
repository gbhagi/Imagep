function [x,map]=gifread(FileName)
% GIFREAD Read a GIF (Graphics Interchange Format) file from disk.
%	[X,MAP]=GIFREAD('filename') reads the file 'filename' and returns
%	the indexed image X and associated colormap MAP. 

if strcmp(version,'4.2c')
  if nargin ~= 1
    error('Requires one input argument.');
  elseif nargin == 1 & isstr(FileName)
    if (isempty(findstr(FileName,'.'))==1)
      FileName=[FileName,'.gif'];
    end
    % Find full filename
    fid = fopen(FileName);
    if fid == -1, error(['File ' FileName ' not found.']); end
    fname = fopen(fid); fclose(fid);
    eval('[x,map] = ungif(fname);');
    x = x + 1;
    x = x';
    map = map(1:max(max(x)),:);
  end
else
  eval('[x,map]=imread(FileName,''gif'');');
end
