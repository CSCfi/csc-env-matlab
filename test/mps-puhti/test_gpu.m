function j = test_gpu()
c = parclusterGPU;
j = batch(c, @gpuDevice, 1, {}, 'CurrentFolder', '.', 'AutoAddClientPath',false)
end
