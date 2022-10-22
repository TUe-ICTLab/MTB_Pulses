beta2=-2.17e-26; % -21.7 ps^2/Km
N=26; % Number of used PSWFs
Wmax=50e9;
epsilon=0.0001;
E=0.01e-12;%0.01pJ
for L=[40:40:160]*1e3 % Length of fiber
cpVec=10:2:20;
if (L==160e3)
    cpVec=10:2:22;
end
% warning: Do not set the following flag to 1 unless you know how to handle
% and monitor the parallel jobs in the cluster
UseParallelCluster=0; % flag: 0 to use sequential for loop, 1 to use the parallel cluster 
if(UseParallelCluster==1)
    ParCluster = parcluster();
    job1 = createJob(ParCluster);
    for cp=cpVec
        Tp=cp/Wmax;
        createTask(job1, @FminconCall, 0, {cp, N, E, Tp,beta2,L, epsilon});
    end
    submit(job1);
else
    for cp=cpVec
        Tp=cp/Wmax;
        FminconCall(cp, N, E, Tp,beta2, L,epsilon);
    end
end

end     

