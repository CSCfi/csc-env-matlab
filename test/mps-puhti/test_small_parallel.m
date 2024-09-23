function j = test_small_parallel()
c = parclusterCPU;
j = batch(c, 'funcParallel', 1, {1}, 'Pool', 8, 'CurrentFolder', '.', 'AutoAddClientPath', false)
end
