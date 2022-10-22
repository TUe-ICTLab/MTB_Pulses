%Y. Jaffal and A. Alvarado, Oct. 2022

L=80e3; % Length of fiber
beta2=-2.17e-26; % -21.7 ps^2/Km
gamma=0.0012; % 1.2 /(W Km)
N=26; % Number of used PSWFs
epsilon=0.0001;
Wmax=50e9;
%For each energy in the following vector, we obtained the corresponding MTB
%pulse and its duration. We used the same steps that we used for the dispersion
%only channel. For more details please check the readme document and the scripts 
%"Main" and "MainMTB" in the folder "DispersionOnly" 
Evec=[1e-14  1e-13 2e-13 3e-13 5e-13 7e-13 8e-13 1e-12 1.2e-12 1.25e-12 1.3e-12 1.4e-12 1.5e-12 1.6e-12 1.7e-12 1.8e-12];
TpVec=[285.5 283.5 280.5 277   271   264   261   254   246.5   244      242.5   237     231.5   225     217     213]*1e-12;
cp=10.5;
% warning: Do not set the following flag to 1 unless you know how to handle
% and monitor the parallel jobs in the cluster
UseParallelCluster=0; % flag: 0 to use sequential for loop, 1 to use the parallel cluster 
if(UseParallelCluster==1)
    ParCluster = parcluster();
    job1 = createJob(ParCluster);
    for iter=1:length(Evec)
        createTask(job1, @FminconCallLossless, 0, {cp, N, Evec(iter), TpVec(iter),beta2,gamma,L,epsilon });
    end
    submit(job1);
else
    for iter=1:length(Evec)
        tic
        FminconCallLossless(cp, N, Evec(iter), TpVec(iter),beta2,gamma, L,epsilon);
        toc
    end
end

%208.4
