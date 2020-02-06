% MAIN_DYNAMIC contains the script to optimize the Fourier sampling pattern 
% for a given dataset and reconstruction method. 
% :params:
%   rate (int, [0-1]): maximal sampling rate, image_size x rate =
%       cardinality constraint
%
%   algo (str): algorithm to be used. The default implementation works was
%   tested with 
%       - k-t FOCUSS ('ktf'), 
%       - Iterative soft-thresholding ('ist'),
%       - ALOHA ('aloha')
%
%   metric (str): performance metric for which the sampling is optimized
%       The metrics implemented are:
%       - 'PSNR_abs': the PSNR of the magnitude of the complex image.
%       - 'PSNR': the PSNR of the complex image
%       - 'SSIM': the structural similarity metric
%       - 'RMSE': the negative root mean-squared error
%
%   orientation (str): orientation of the mask in the Fourier space, can be
%   either horizontal or vertical
%
%   sampling (str): what kind of sampling strategy is used for the lines in
%   the greedy method. The following are available.
%       - 'full': amounts to the full greedy method (G in the paper), where
%       every possible line is tested at each iteration
%       - 'one_frame': (not in the paper) amounts to cycling through the
%       frame and testing all possible lines from a SINGLE frame at each
%       greedy iteration.
%       - 'stochastic': (not in the paper) amounts to a randomly selected
%       batch of lines **from any frame**.
%       - 'stochastic_one_frame': (SCG) amounts to a randomly selected
%       batch of lines **from a given frame**. 
%       Cycling through the frames is performed as iterations go.      
%
%   n_samp_rand (int): (k in the paper) controls the size of the batch of 
%       lines used at each iteration if sampling is 'stochastic' or 
%       'stochastic_one_frame'.
%
%   sample_selection (str): what kind of sampling strategy is used for the
%       data points at each iteration of the greedy method. The following are
%   available:
%       - 'full': every element of the training dataset is processed at
%       each iteration
%       - 'stochastic': a randomly selected batch is used.
%
%   ntr (int): (l in the paper) controls the size of the batch of training
%       data used at each iteration if sample_selection is 'stochastic'
%
%   results_folder ('str'): the folder where the results should be saved
%
%   training_image ('str'): the path to the training data. The data should
%       have 4 dimensions (spatial x spatial x time x ndata).
%
%   t_samp (list of int): the indices of the frames that will be used for
%       training.
%
%   tr_samp (list of int): the indices of the data points that will be used for
%       training.
%
%   x_size (list of int): the x spatial dimension of the data (cropping)
%
%   y_size (list of int): the y spatial dimension of the data (cropping)
%
%   low_phase (list of int): the indices of the low frequency phase encodes
%       that should always be acquired (low-frequencies are centered in the
%       image)
%
% Thomas Sanchez - 2020
%% SIMULATION SETUP -- VARIABLES 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. FUNDAMENTAL PARAMETERS

rate   = 0.32; % sampling rate
algo   = 'ktf';  % Algorithm used -> 'ktf', 'ist', 'aloha'
metric = 'PSNR_abs'; % Error metric used

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. GREEDY ALGORITHM RELATED PARAMETERS
orientation = 'horizontal'; % vertical / horizontal 
                            
sampling = 'stochastic_one_frame'; % 'full': iterate over all frames each time;
                         % 'one_frame': iterate over one frame at a time and cycles through them;
                         % 'stochastic': selectes n_samp_rand uniformly at random.
                         % 'stochastic_one_frame' : selects n_nsamp_rand uniformly at random while cycling through the frames.
n_samp_rand = 4; % If the sampling is stochastic, then sets the size of the batch sampled randomly at each iteration.

sample_selection = 'random'; % Whether we use the full training images or do a stochastic approximation in this step as well.
ntr = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. GENERAL PARAMETERS

results_folder = 'results/';
training_image = '../data/cardiac_single_coil';
t_samp = 1:17; tr_samp = 1:3;
x_size = 1:152; y_size = 1:152;
low_phase = 73:78;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imports
addpath(genpath('dynamic_sgMRI_toolbox'))
addpath(genpath('dynamic_sgMRI_toolbox/helpers'))

%% SIMULATION  
greedy_algo