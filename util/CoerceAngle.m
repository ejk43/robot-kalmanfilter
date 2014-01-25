function [ out ] = CoerceAngle( in, domain )
%COERCEANGLE Coerces an angle to domain -pi to pi

out = mod(in,domain);
out(out>domain/2) = out(out>domain/2) - domain;

end

