clear all;
L=80e3; % Length of fiber
beta2=-2.17e-26; % -21.7 ps^2/Km
N=26; % Number of used PSWFs
Wmax=50e9;
E=0.01e-12;
epsilon=0.0001;
LVec=[40 80 120 160]*1e3; % different Distances
TpVec=[202 285.5 350 404]*1e-12; % corresponding duration of MTB pulses, example Tp=202ps for L=40Km,...
cpVec=[10 14 16 20]; % corresponding time bandwidth product of the used prolate spheroidal wave functions
% warning: Do not set the following flag to 1 unless you know how to handle
% and monitor the parallel jobs in the cluster
UseParallelCluster=0; % flag: 0 to use sequential for loop, 1 to use the parallel cluster 
if(UseParallelCluster==1)
    ParCluster = parcluster();
    job1 = createJob(ParCluster);
    for iter=1:4
        createTask(job1, @FminconCall, 0, {cpVec(iter), N, E, TpVec(iter),beta2,LVec(iter), epsilon });
    end
    submit(job1);
else
    for iter=1:4
        FminconCall(cpVec(iter), N, E, TpVec(iter),beta2,LVec(iter),epsilon);
    end
end