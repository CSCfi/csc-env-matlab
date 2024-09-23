function j = test_large_parallel()
c = parclusterCPU;
j = batch(c, 'funcParallel', 1, {1}, 'Pool', 50, 'CurrentFolder', '.', 'AutoAddClientPath', false)
end
