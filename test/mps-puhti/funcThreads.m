function t = funcThreads(n)
pool = parpool('Threads', n);
t = funcParallel(n);
delete(pool);
end