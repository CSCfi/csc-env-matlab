function t = funcProcesses(n)
pool = parpool('Processes', n);
t = funcParallel(n);
delete(pool);
end