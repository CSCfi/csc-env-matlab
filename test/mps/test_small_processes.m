function j = test_small_processes()
n = 2;
c = parcluster();
c.AdditionalProperties.ComputingProject = 'project_2001659';  % --account=<ComputingProject>
c.AdditionalProperties.Partition = 'test';             % --partition=<Partition>
c.AdditionalProperties.WallTime = '00:15:00';           % --time=<WallTime>
c.NumThreads = n;                                       % --cpus-per-task=<NumThreads>
c.AdditionalProperties.MemPerCPU = '2g';                % --mem-per-cpu=<MemPerCPU>
c.AdditionalProperties.GPUCard = '';                    % --gres=gpu:<GPUCard>:<GPUsPerNode>
c.AdditionalProperties.GPUsPerNode = 0;
j = batch(c, @funcProcesses, 1, {n}, 'CurrentFolder', '.', 'AutoAddClientPath', false);
end
