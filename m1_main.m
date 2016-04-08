% The main script. The two .png files contain the final results. 
% 2016-4-8 15:57:14

clear,clc;

m1_download;     % Download the NIFTI toolbox and Craddock's demo data
m1_prepare;      % Prepare for parcellation
m1_parc;         % Perform parcellation
m1_illustration; % Draw illustratons
m1_eval;         % Calculate evaluation metrics
m1_summ;         % Summarize the evaluation metrics
m1_plot;         % Plot the evaluation metrics