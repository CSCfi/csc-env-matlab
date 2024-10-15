function j = test_small_serial()
c = parclusterCPU;
c.NumThreads = 2;
j = batch(c, 'funcSerial', 1, {1}, 'CurrentFolder', '.', 'AutoAddClientPath', false)
end
