clear; clc;  %czyscimy workspace i konsole
%{
%}

A = [1,2,3,4;25,16,9,4;2,3,5,7;8,3,2,5];
b = [1;2;3;4]; %[1,2,3,4]' <- transponowane

dA = det(A);
x=[];

for i = 1:4
    tmpA=A;
    tmpA(:,i)=b;
    det(tmpA)/dA;
    x(i)=det(tmpA)/det(A);
end

x;


