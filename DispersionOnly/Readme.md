% This software belongs to the paper: 
%"Time-Limited Waveforms with Minimum Time Broadening for the Nonlinear
%Schrodinger Channel" by Y. Jaffal and A. Alvarado
%Y. Jaffal and A. Alvarado, Oct. 2022

The following is the procedure to find the MTB pulses:

1. Obtain a figure similar to Fig. 5 of the paper:
  - Run the script "Main.m" to find the optimal pulse when Tp=c/Wmax
  - Try many initial vectors for the optimization (xinit in 'Fmincall.m'), including the ones obtained for the other pulses
  - Obtain a figure similar to figure 5, and approximate the intersection point, in our case it is 285.5ps

2. Find the timebandwidth product of the pulses between which the intersection in Fig. 5 occurs
  - In the paper we find it for the pulses at Tp=280ps and Tp=320ps, and they are 8.57 and 9.42 respectively
  - Now we can use the PSWFs with any time bandwidth product between (max(8.57,9.42)) and (285.5ps * 50 GHz), in our case we used cp=14 for the PSWFs

3. Run the script MainMTB.m using the timebandwidth product found in step 2, and the approximated Tp in step 1
  - In Fmincall try different initial vectors for the optimization, including the ones obtained for the other pulses
