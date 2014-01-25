function [ out ] = wrap( in, domain )
%WRAP Wraps an angle to -domain/2 to +domain/2

out = mod(in,domain);
out(out>domain/2) = out(out>domain/2) - domain;

end

