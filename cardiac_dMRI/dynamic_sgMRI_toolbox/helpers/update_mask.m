% UPDATE_MASK updates the mask according to the best index previously
% found.
%
% Thomas Sanchez - 2020

% Update the labels corresponding to the sample increasing most the
% performance metric.
if isnan(max_objective)
   max_objective = 0;  
end

[max_objective,selected_index]  =  max((average_objective_value(:)));



selected_index2 = label_elements(selected_index);
label(selected_index2) = 1;

%Update the mask, and the rates
if  strcmp(orientation,'horizontal')
    [x,y,t] = ind2sub(size(label), selected_index2);
    for i = 1:size(x,1)
        mask(x(i),:,t(i)) = 1;
    end
else
    [x,y,t] = ind2sub(size(label),selected_index2);
    for i = 1:size(x,2)
        mask(:,y(i),t(i)) = 1;
    end       
end
  
rate_i = sum(mask(:))/numel(mask);
