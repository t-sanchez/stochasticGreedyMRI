% MAIN_STATIC contains the script to optimize the Fourier sampling pattern 
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
%   ntr (int): (l in the paper) controls the size of the batch of training
%       data used at each iteration.
%
%   results_folder ('str'): the folder where the results should be saved
%
%   data_path ('str'): the path to the training data. The data should
%       have 4 dimensions (spatial x spatial x time x ndata).
%
%   tr_samp (list of int): the indices of the data points that will be used for
%       training.
%
%   nx (int): the x spatial dimension of the data (cropping)
%
%   ny (int): the y spatial dimension of the data (cropping)
%
%   low_phase (list of int): the indices of the low frequency phase encodes
%       that should always be acquired (low-frequencies are centered in the
%       image)
%
% Thomas Sanchez - 2020
%% SIMULATION SETUP -- VARIABLES 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Main parameters

rate   = 0.502; % Target sampling rate
metric = 'PSNR_abs'; % Error metric used

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.Greedy algorithm parameters
orientation = 'horizontal'; % vertical / horizontal / radial
                            
sampling = 'stochastic'; % 'full' (G in the paper): iterate over all frames each time ;
                         % 'stochastic' (SG in the paper): selectes n_samp_rand uniformly at random.
                         
n_samp_rand = 80; % number of candidate lines used at each greedy iteration, k in the paper
ntr = 2; %ntr: number of training examples used at each iteration, l in the paper

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. GENERAL PARAMETERS
results_folder = 'results/'; 
nx = 320; ny = 320;
low_phase = 158:163;
data_path = '../data/singlecoil_train';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imports
addpath(genpath('static_sgMRI_toolbox'))
addpath(genpath('static_sgMRI_toolbox/helpers'))

%% SIMULATION  
greedy_algo

