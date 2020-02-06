function [mask_temp] = design_mask_temp(j, label, mask, orientation)
% DESIGN_MASK_TEMP designs the mask that will be tested by the current
% iteration of the reconstruction algorithm from the list of indices.
% :params:
%   j: index to be added to the mask
%   label: compact representation of the current mask
%   mask: current mask
%   orientation: 'vertical'/'horizontal'
% :returns:
%   mask_temp: the mask to be tested in the current iteration
%
% Thomas Sanchez - 2020


mask_temp = mask;

if  strcmp(orientation,'horizontal')
    [x, ~ ,t] = ind2sub(size(label),j);
    for iter = 1:size(x,1)
        mask_temp(x(iter),:,t(iter)) = 1;
    end

elseif strcmp(orientation,'vertical')
    [x,y,t] = ind2sub(size(label),j);
    for iter = 1:size(x,2)
        mask_temp(:,y(iter),t(iter)) = 1;
    end
else 
    error('Unknown orientation')
end

end