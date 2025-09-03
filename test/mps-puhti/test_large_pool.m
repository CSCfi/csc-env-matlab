function j = test_large_parallel()
c = parclusterCPU;
c.NumThreads = 1;
j = batch(c, 'funcParallel', 1, {1}, 'Pool', 50, 'CurrentFolder', '.', 'AutoAddClientPath', false)
end
