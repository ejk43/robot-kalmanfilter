function [ rval ] = checkSysErrPseudoUpdate( settings, ts )
%CHECKSYSERRPSEUDOUPDATE Checks the kalman filter settings to see whether
%we should coerce the systematic odometry error states to equal 0

rval = false;
if settings.kf.forceSysErr && settings.kf.useSystemParams
    timevalid = settings.kf.forceSysErrTime;
    if isempty(timevalid)
        rval = true;
    elseif any(timevalid(:,1)<=ts & ts<timevalid(:,2))
        rval = true;
    end
end
    
end

