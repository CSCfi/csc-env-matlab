function c = parclusterGPU()

c = parcluster;
c.AdditionalProperties.ComputingProject = 'project_2001659';
c.AdditionalProperties.Partition = 'gputest';
c.AdditionalProperties.WallTime = '00:15:00';
c.AdditionalProperties.CPUsPerNode = 1;
c.AdditionalProperties.MemPerCPU = '4g';
c.AdditionalProperties.GpuCard = 'v100';
c.AdditionalProperties.GPUsPerNode = 1;
c.AdditionalProperties.EmailAddress = '';

end
