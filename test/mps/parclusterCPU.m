function c = parclusterCPU()

c = parcluster;
c.AdditionalProperties.ComputingProject = 'project_2001659';
c.AdditionalProperties.Partition = 'test';
c.AdditionalProperties.WallTime = '00:15:00';
c.AdditionalProperties.CPUsPerNode = '';
c.AdditionalProperties.MemPerCPU = '2g';
c.AdditionalProperties.GpuCard = '';
c.AdditionalProperties.GPUsPerNode = '';
c.AdditionalProperties.EmailAddress = '';

end
