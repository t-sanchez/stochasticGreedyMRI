% PREPARE_SAMPLING prepares the sampling for the greedy algorithm iteration
%   It distinguishes between:
%       1.  Full sampling, and prepares the sampling over the whole set of 
%           not yet added samples.
%       2.  One frame sampling, and prepares the frames in cycles.
%
% Thomas Sanchez - 2020


if strcmp(sampling, 'full')
    
    label_elements    = find(label==0);         % rows/columns that are not yet added 
    fprintf('Greedy algorithm iteration %d\n', counter_mask) 

elseif strcmp(sampling,'stochastic')
     label_elements    = find(label==0);         % rows/columns that are not yet added 
     if n_samp_rand < numel(label_elements)
        label_elements = datasample(label_elements,n_samp_rand,'Replace',false);
     else
         fprintf('The number of sampling elements required is larger than the number of samples not yet added.\n')
     end
else
    error('Unkown sampling')
end

% Prepare the batch of training data used in subsequent reconstrucion.
[x_original,k_original,batch] = get_2D_batch(ntr, data_path, [nx, ny]);

