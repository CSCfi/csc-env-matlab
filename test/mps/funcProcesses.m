function t = funcProcesses(n)
pool = parpool('Processes', n);
disp(funcParallel(n));
t = funcParallel(n);
disp(t);
delete(pool);
end