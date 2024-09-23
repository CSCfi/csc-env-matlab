function j = test_small_serial()
c = parclusterCPU;
j = batch(c, 'funcSerial', 1, {1}, 'CurrentFolder', '.', 'AutoAddClientPath', false)
end
