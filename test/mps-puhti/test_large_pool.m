function j = test_large_pool()
c = parcluster();
c.AdditionalProperties.ComputingProject = 'project_2001659';  % --account=<ComputingProject>
c.AdditionalProperties.Partition = 'test';             % --partition=<Partition>
c.AdditionalProperties.WallTime = '00:15:00';           % --time=<WallTime>
c.NumThreads = 1;                                       % --cpus-per-task=<NumThreads>
c.AdditionalProperties.MemPerCPU = '2g';                % --mem-per-cpu=<MemPerCPU>
c.AdditionalProperties.GPUCard = '';                    % --gres=gpu:<GPUCard>:<GPUsPerNode>
c.AdditionalProperties.GPUsPerNode = 0;
j = batch(c, @funcParallel, 1, {1}, 'Pool', 50, 'CurrentFolder', '.', 'AutoAddClientPath', false);
end
