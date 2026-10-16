function t = funcThreads(n)
pool = parpool('Threads', n);
disp(funcParallel(n));
t = funcParallel(n);
disp(t);
delete(pool);
end