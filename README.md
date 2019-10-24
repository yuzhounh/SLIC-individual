# Parcellating whole brain for individuals by simple linear iterative clustering
Copyright (C) 2016 Jing Wang

Generating whole brain atlas with resting-state fMRI data using normalized cuts (Ncut) and simple linear iterative clustering (SLIC). The parcellaiton
is only performed in the individual subject level. In order to generate parcellations with multiple granularities, we vary the cluster number in a 
wide range. The two parcellation algorithms are compared under four evaluation metrics, i.e., the difference between the initialized cluster 
number and the average actual cluster number, spatial discontiguity index, functional homogeneity and reproducibility. 

For a light version of this project which consumes less memory and could run on a personl computer, see https://github.com/yuzhounh/SLIC_individual-light.
This version is kept as default since it is more concise and more extensible. 

## Usage:
Run m1_main.m to play the demo. 

## Notes:
1. You might download the NIFTI toolbox and the demo data manually.  
2. For parallel computing, carefully choose the number of parallel workers to make the most of the hardware resources and to avoid problems such
   as the out of memory problem.  
3. It requires quite a lot of memory even with only 3 parallel workers, so it is suggested to run on a server rather than a personal computer. You
   might set more parallel workers if accessible.  
4. The number of redundant eigenvectors is set arbitrarily, and should be set larger in case of error when applying the scripts on other databases. 

## Contact information:
Jing Wang  
wangjing0@seu.edu.cn  
yuzhounh@163.com  
2016-4-8 23:01:55
