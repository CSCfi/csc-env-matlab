function j = test_small_serial()
c = parcluster;
c.AdditionalProperties.ComputingProject = 'project_2001659';  % --account=<ComputingProject>
c.AdditionalProperties.Partition = 'test';             % --partition=<Partition>
c.AdditionalProperties.WallTime = '00:15:00';           % --time=<WallTime>
c.NumThreads = 1;                                       % --cpus-per-task=<NumThreads>
c.AdditionalProperties.MemPerCPU = '4g';                % --mem-per-cpu=<MemPerCPU>
c.AdditionalProperties.GPUCard = '';                    % --gres=gpu:<GPUCard>:<GPUsPerNode>
c.AdditionalProperties.GPUsPerNode = '';
j = batch(c, 'funcSerial', 1, {1}, 'CurrentFolder', '.', 'AutoAddClientPath', false);
end
