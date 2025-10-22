function j = test_gpu()
c = parcluster();
c.AdditionalProperties.ComputingProject = 'project_2001659';  % --account=<ComputingProject>
c.AdditionalProperties.Partition = 'gputest';               % --partition=<Partition>
c.AdditionalProperties.WallTime = '00:15:00';           % --time=<WallTime>
c.NumThreads = 4;                                      % --cpus-per-task=<NumThreads>
c.AdditionalProperties.MemPerCPU = '1g';                % --mem-per-cpu=<MemPerCPU>
c.AdditionalProperties.GPUCard = 'v100';                % --gres=gpu:<GPUCard>:<GPUsPerNode>
c.AdditionalProperties.GPUsPerNode = 1;
j = batch(c, 'funcGPU', 1, {1000}, 'CurrentFolder', '.', 'AutoAddClientPath',false);
end