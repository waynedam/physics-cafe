%% 0. INITIALIZE
clear all; close all; clc; format short e; format compact; warning off

%% Generate Hermitian matrix.
% A = rand(3);
% Make positive definite (all eigenvalues > 0) by multiplying by
% transpose
% A = A*A' 

% A = [1 2 3; 2 4 5; 3 5 6]

A = ...
   [5.0526e-01   6.6067e-01   4.6911e-01; ...
   6.6067e-01   1.2941e+00   9.9078e-01; ...
   4.6911e-01   9.9078e-01   1.3270e+00]

%% Calculate its eigen-decomposition.
[U,D] = eig(A)

% Get orthonormal basis vectors.
u1=U(:,1); u2=U(:,2); u3=U(:,3);

%% Generate standard basis and plot them plus new basis from the Hermitian matrix, A.
e1=[1;0;0];
e2=[0;1;0];
e3=[0;0;1];

figure(1); clf; hold on; axis equal; grid on

plotvector(e1,1,'k',2)
plotvector(e2,1,'k',2)
plotvector(e3,1,'k',2)

plotvector(u1,1,'r',2)
plotvector(u2,1,'r',2)
plotvector(u3,1,'r',2)
text(u1(1),u1(2),u1(3),'u1')
text(u2(1),u2(2),u2(3),'u2')
text(u3(1),u3(2),u3(3),'u3')

%% Generate a vector we are going to operate on with projections and plot it.
% x = rand(3,1); x=x/sqrt((x'*x));
x = [ 5.3635e-01; 1.4139e-01; 8.3207e-01 ]
   
plotvector(x,1,'b',2)
text(x(1),x(2),x(3),'x','Color','blue')

%% Project into the u1/u2 linear subspace (a plane).
P12 = u1*u1' + u2*u2'
x12 = P12*x

plotvector(x12,1,'g',2)
text(x12(1),x12(2),x12(3),'x12','Color','green')

%% Project into the u2 linear subspace (a line).
P3 = u3*u3'
x3 = P3*x

plotvector(x3,1,'g',2)
text(x3(1),x3(2),x3(3),'x2','Color','green')

