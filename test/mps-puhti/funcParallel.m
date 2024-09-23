function t = funcParallel(n)
t0 = tic;
parfor idx = 1:n
    pause(1);
end
t = toc(t0);
end
