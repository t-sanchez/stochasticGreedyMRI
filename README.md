
# SG-MRI v1.0
**SG-MRI** is a MATLAB software package for optimizing the Fourier space Cartesian sampling masks for given training data and any reconstruction method. 

The problem of optimizing the measurements in magnetic resonance imaging (MRI) is tied with the overall problem of accelerating MRI, in order to make it applicable to cases where it is currently prohibitively slow, and reduce the overall costs associated with this modality. 

**SG-MRI** was developed to improve the scalability of the [LBCS-MRI](https://www.epfl.ch/labs/lions/technology/lb-csmri-2/) method of 
Gözcü et al. [1] by leveraging a stochastic greedy method using minibatches 
of data and of possible combinations at each iteration.  

## Citing

If you use the SG-MRI code or data in your research, please consider citing the SG-MRI paper:
```
@inproceedings{sanchez2020scalable,
  title={Scalable learning-based sampling optimization for compressive dynamic {MRI}},
  author={Sanchez, Thomas and G{\"o}zc{\"u}, Baran and van Heeswijk, Ruud B and Eftekhari, Armin and Il{\i}cak, Efe and {\c{C}}ukur, Tolga and Cevher, Volkan},
  booktitle={2020 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)},
  year={2020},
    organization={IEEE}
}
```

The preprint of the paper is currently available on [arXiv](https://arxiv.org/pdf/1902.00386.pdf).

## Directory Structure

-   `cardiac_dMRI`: Contains the dynamic cardiac experiment, where the masks can be optimized for k-t FOCUSS [2], ALOHA [3] and Iterative soft-thresholding [4]. 
- `knee_fastMRI_static`: Contains the knee static MRI experiment, where the masks can be optimized using TV-regularized iterative reconstruction.
-   `data`: Contains the cardiac data for the dynamic experiment. 
 
## Installation 

After cloning the repository, some additional files are required for a proper execution of the method.

### For the dynamic data
1. Download the *k-t FOCUSS* [2] implementation from 
https://bispl.weebly.com/k-t-focuss.html
and copy the `bin` folder to  `cardiac_dMRI/dynamic_sgMRI_toolbox`.
2. Download the *ALOHA* [3] implementation from
https://bispl.weebly.com/aloha-for-mr-recon.html
and unpack the ` aloha_public/kt/CPU/bin` folder to `cardiac_dMRI/dynamic_sgMRI_toolbox`.
3. Run `cardiac_dMRI/main_dynamic.m`. The parameters are detailed within the script. 

### For the static data.
1. Download the NESTA [5] solver from 
https://statweb.stanford.edu/~candes/nesta/ 
and unpack it in the `knee_fastMRI_static/static_sgMRI_toolbox` directory 
2. Download the fastMRI [6] single coil knee training data from the [fastMRI website](https://fastmri.med.nyu.edu) and unpack it in the folder `data/singlecoil_train`.
3. Run `knee_fastMRI_static/main_dynamic.m`. The parameters are detailed within the script. 

#### Notes
- It is possible to implement/call your reconstruction algorithm of preference in the function `reconstruct.m` in both the static and dynamic cases.
- It is possible to use your own data for the mask training procedure. The path to the data is specified in the main scripts. 
	- The dynamic script can be used with any raw MRI single coil data. The .mat file loaded should contain a complex dataset of dimension *spatial_x* x *spatial_y* x *time* x *num_train*.
	- The static script is currently only compatible with the .h5 files of fastMRI.
	- The scripts can be run in parallel by changing the `for`loop to a `parfor`loop in the `greedy_algo.m`script.


## References
[1] B. Gözcü, R. K. Mahabadi, Y. H. Li, E. Ilıcak,  T. Çukur, J. Scarlett, 
and V. Cevher. *Learning-Based Compressive MRI.* IEEE Transactions on Medical Imaging (2018)
[2]Jung, H., et al. *k‐t FOCUSS: a general compressed sensing framework for high resolution dynamic MRI.*
Magn Reson Med. 61.1 (2009): 103-116.
[3] Jin, K. H., Lee D., and Ye, J.C. *A general framework for compressed sensing and parallel MRI using annihilating filter based low-rank Hankel matrix.*
 IEEE TCI 2.4 (2016): 480-495.
 [4] Otazo R, Kim D, Axel L, Sodickson DK. *Combination of compressed sensing and parallel imaging for highly accelerated first-pass cardiac perfusion MRI*. Magn Reson Med. 2010; 64(3):767-76.
[5] Becker, S., Bobin, J., & Candès, E. J. (2011). *NESTA: A fast and accurate first-order method for sparse recovery*. 
SIAM Journal on Imaging Sciences, 4(1), 1-39.
[6] Zbontar, J., et al. *fastMRI: An open dataset and benchmarks for accelerated MRI.* arXiv preprint arXiv:1811.08839 (2018).
 
## Copyright
SG-MRI is a free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License, found in the LICENSE file.