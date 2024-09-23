module load matlab/r2024a
matlab -nodesktop -nosplash
mex -v MyMEXFunction.cpp

will create binary:
MyMEXFunction.mexa64

try to run it inside Matlab, an example

b = MyMEXFunction(11.5, rand(1000));

Document is this ( Create a C++ MEX Source File ):
https://se.mathworks.com/help/matlab/matlab_external/c-mex-source-file.html

