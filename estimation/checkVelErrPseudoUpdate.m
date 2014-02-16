function [ rval ] = checkVelErrPseudoUpdate( settings, ts )
%CHECKVELERRPSEUDOUPDATE Checks the kalman filter settings to see whether
%we should coerce the wheel velocity error states to equal 0

rval = false;
if settings.kf.forceVelErr && settings.kf.useWheelError
    timevalid = settings.kf.forceVelErrTime;
    if isempty(timevalid)
        rval = true;
    elseif any(timevalid(:,1)<ts & ts<timevalid(:,2))
        rval = true;
    end
end
    
end

