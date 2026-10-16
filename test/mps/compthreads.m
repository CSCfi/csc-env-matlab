A = rand(1000, 1000);
% One thread
maxNumCompThreads(1);
t0 = tic;
B = A*A;
t1 = toc(t0);
% Two threads
maxNumCompThreads(2);
t2 = tic;
C = A*A;
t3 = toc(t2);
% Compare times
fprintf("One thread : %d\nTwo threads: %d\n", t1, t3);