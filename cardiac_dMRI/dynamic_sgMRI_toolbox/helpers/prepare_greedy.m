%PREPARE_GREEDY prepares the greedy algorithm run by setting up the
% relevant variables.
%
% Thomas Sanchez - 2020


% Load and format training data
load(training_image); 

x_original = im(x_size,y_size,t_samp,tr_samp);
k_original = fft2_d(x_original);

clear t_samp tr_samp

%Size of k_original needed as we will design the mask from the k-space.
[nx, ny, nt, ntr_tot] =  size(k_original);

% Prepare paths
if ~(7 == exist(results_folder,'dir'))
   mkdir(results_folder )
end

% Prepare variables
rate_grid = 0:0.025:rate; % Sampling grid declaration - Rate at which data are saved
mask = zeros(nx,ny,nt); % Sampling mask initalized
label_selected = []; % Selected labels

if strcmp(orientation,'horizontal')
       mask(low_phase,:,:) = 1;
       label_selected = find(squeeze(mask(:,1,:)));  
       rate_i_vector = 1/nx/nt*(1:numel(label_selected))'; % Init. sampling rate
       
       
elseif strcmp(orientation,'vertical')
       mask(:,low_phase,:) = 1;    
       label_selected = find(squeeze(mask(1,:,:)));
       rate_i_vector = 1/ny/nt*(1:numel(label_selected))';
else
    error('Unknown orientation.')
end

% Output variables
rate_i = sum(mask(:))/numel(mask) ;
objective_greedy = zeros(size(label_selected));
mask_evolution = [];
max_objective = 0;

rate_grid_save = 1;
counter_mask = 1;
error_tot = {};
selected_volumes = {};

if strcmp(orientation,'horizontal')
    label = zeros(nx, 1, nt); 
    label(low_phase,:,:) = 1; % Selected low_phase labels.
elseif strcmp(orientation,'vertical')
    label = zeros(1, ny, nt);   
        label(:,low_phase,:) = 1; % Selected low_phase labels.

else
    error('Unknown orientation.')
end


