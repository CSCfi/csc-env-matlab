function j = test_small_parallel()
c = parclusterCPU;
c.NumThreads = 1;
j = batch(c, 'funcParallel', 1, {1}, 'Pool', 8, 'CurrentFolder', '.', 'AutoAddClientPath', false)
end
