function C = funcGPU(n)
gpuDevice();
A_gpu = gpuArray(rand(n, n));
B_gpu = gpuArray(rand(n, n));
C_gpu = A_gpu * B_gpu;
C = gather(C_gpu);
end
