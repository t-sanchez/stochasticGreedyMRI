% GREEDY_ALGO performs the greedy algorithm simulation, iteratively adding
% to the sampling set the indices which most increase a performance
% function.
%   Most of the functions and scripts used in this algorithm are defined in
%   minimal_toolbox/helpers, each explaining in further detail their
%   purpose.
%
% Thomas Sanchez - 2020

%% Setting up the greedy algorithm run

% Preparing the greedy run, setting up the important variables.
prepare_greedy;

while rate_i < rate
    
    prepare_sampling;
    average_objective_value  = zeros(numel(label_elements),1);

    time_init = tic;
    
        %This loop can be changed to a parfor loop for parallel
        %computations
        parfor i = 1:numel(average_objective_value)
        %Parfor loop: 
        % 1. Add temporarily an element of S to the  and see the
        % reconstruction error that you get.
        % 2. Iterate over all elements of S that are not yet in Omega.

        parfor_it = i;
        j         = label_elements(i);

        mask_temp = design_mask_temp(j,label, mask, orientation);
            
        objective_value = zeros(ntr,1);
        
        for abc = 1:ntr
            % Reconstruct data and record performance
            x_recon = reconstruct(x_original(:,:,abc), mask_temp);
            objective_value(abc) = compute_error(x_original(:,:,abc), x_recon, metric);
  
        end
            
        average_objective_value(i) = mean(objective_value);
        
        
        fprintf('Parfor iteration %d - %s = %f\n', parfor_it,metric,average_objective_value(i) )

        end
    
        parfor_it_time = toc(time_init)

    %%
    % Greedy algorithm step: Find the step that increases most the
    % reconstruction metric (e.g. PSNR) and update the mask to include the
    % corresponding pixels into it. 
    update_mask; 
    
    fprintf('Greedy algorithm iteration %d terminated - rate %.7f / %.4f\n\t %s: %.4f\n', counter_mask, rate_i, rate, metric, max_objective) 

    save_iter;
    
end
