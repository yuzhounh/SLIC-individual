# Parcellating whole brain for individuals by simple linear iterative clustering

MATLAB experiments for individual whole-brain parcellation using normalized cuts and simple linear iterative clustering.

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-D4AF37?style=flat-square)](LICENSE)

Copyright (C) 2016 Jing Wang

Generating whole brain atlas with resting-state fMRI data using normalized cuts (Ncut) and simple linear iterative clustering (SLIC). The parcellation
is only performed in the individual subject level. In order to generate parcellations with multiple granularities, we vary the cluster number in a 
wide range. The two parcellation algorithms are compared under four evaluation metrics, i.e., the difference between the initialized cluster 
number and the average actual cluster number, spatial discontiguity index, functional homogeneity and reproducibility. 

For a light version of this project which consumes less memory and could run on a personal computer, see https://github.com/yuzhounh/SLIC-individual-light.
This version is kept as default since it is more concise and more extensible. 

## Prerequisites and Execution

Use MATLAB with Parallel Computing Toolbox and run from the repository directory. [m1_download.m](m1_download.m) expects `NIfTI_20140122.zip` and `SLIC_individual_data.zip` and attempts to download missing archives. Review subject and worker settings first.

[m1_prepare.m](m1_prepare.m) decompresses and deletes root-level `*.gz` files and moves the selected subject images into `data/`. Use a dedicated experiment directory. Historical download endpoints and current MATLAB compatibility have not been revalidated.

## Quick Start
Run m1_main.m to play the demo. 

## Notes
1. You might download the NIFTI toolbox and the demo data manually.  
2. For parallel computing, carefully choose the number of parallel workers to make the most of the hardware resources and to avoid problems such
   as the out of memory problem.  
3. It requires quite a lot of memory even with only 3 parallel workers, so it is suggested to run on a server rather than a personal computer. You
   might set more parallel workers if accessible.  
4. The number of redundant eigenvectors is set arbitrarily, and should be set larger in case of error when applying the scripts on other databases. 

## Repository Structure

- [m1_main.m](m1_main.m): workflow.
- [m1_prepare.m](m1_prepare.m): inputs and configuration.
- [m1_parc.m](m1_parc.m), [m1_eval.m](m1_eval.m), and [m1_plot.m](m1_plot.m): stages.
- [manuscript.pdf](manuscript.pdf), [evaluation.png](evaluation.png), and [parcellations.png](parcellations.png): paper and example figures.

## License

See the existing [GPL-3.0 license](LICENSE).

## Contact
Jing Wang  
wangjing0@seu.edu.cn  
yuzhounh@163.com  
2016-4-8 23:01:55
