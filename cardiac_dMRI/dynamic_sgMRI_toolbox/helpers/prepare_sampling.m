% PREPARE_SAMPLING prepares the sampling for the greedy algorithm iteration
%   It distinguishes between:
%       1.  Full sampling, and prepares the sampling over the whole set of 
%           not yet added samples.
%       2.  One frame sampling, and prepares the frames in cycles.
%
% Thomas Sanchez - 2020

% 
if strcmp(sampling, 'full')
    
    label_elements    = find(label==0);         % rows/columns that are not yet added 
    fprintf('Greedy algorithm iteration %d\n', counter_mask) 

elseif strcmp(sampling, 'one_frame')

    frame_selected = mod(counter_mask-1,nt)+1; %Choose the frame on which we're iterating

    if strcmp(orientation,'horizontal')
        frame_indices  = ((frame_selected-1)*nx+1):frame_selected*nx; %Create the list of indices which correspond to that frame
    elseif strcmp(orientation,'vertical')
        frame_indices  = ((frame_selected-1)*ny+1):frame_selected*ny; %Create the list of indices which correspond to that frame
    else
        error('Unknown orientation.')
    end

    fprintf('Greedy algorithm iteration %d - Selected frame %d\n', counter_mask, frame_selected)
    label_elements = find(label==0); %Find all non-zero indices
    label_elements = intersect(label_elements,frame_indices); %Find all non-zero indices that are in the frame of interest

    
elseif strcmp(sampling,'stochastic')
     label_elements    = find(label==0);         % rows/columns that are not yet added 

     if n_samp_rand < numel(label_elements)
        label_elements = datasample(label_elements,n_samp_rand,'Replace',false);
     else
         fprintf('The number of sampling elements required is larger than the number of samples not yet added.\n')
     end
     
elseif strcmp(sampling,'stochastic_one_frame')
    
    frame_selected = mod(counter_mask-1,nt)+1; %Choose the frame on which we're iterating

    if strcmp(orientation,'horizontal')
        frame_indices  = ((frame_selected-1)*nx+1):frame_selected*nx; %Create the list of indices which correspond to that frame
    elseif strcmp(orientation,'vertical')
        frame_indices  = ((frame_selected-1)*ny+1):frame_selected*ny; %Create the list of indices which correspond to that frame
    else
        error('Unknown orientation.')
    end

    fprintf('Greedy algorithm iteration %d - Selected frame %d\n', counter_mask, frame_selected)
    label_elements = find(label==0); %Find all non-zero indices
    label_elements = intersect(label_elements,frame_indices); %Find all non-zero indices that are in the frame of interest
    
     if n_samp_rand < numel(label_elements)
        label_elements = datasample(label_elements,n_samp_rand,'Replace',false);
     else
         fprintf('The number of sampling elements required is larger than the number of samples not yet added.\n')
     end     
else
    error('Unkown sampling')
end


if strcmp(sample_selection,'full')
    samp = 1:size(k_original,4);
    
elseif strcmp(sample_selection,'random')
    samp = datasample(1:size(k_original,4),ntr,'Replace',false);
else
    error('Unknown sample selection type')
end  



