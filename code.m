% EE4530 Applied Convex Optimisation Project 5
clc
clear all
load('cs.mat')
n = 128;
m = n/4;
freq = find(sampling_mask==1);
A = [real(F_us(freq,:)); imag(F_us(freq,:))];
X_us(find(X_us==0))=[];
b = [real(X_us); imag(X_us)]; % b = A*x;
% CVX implementaion
t_start1 = cputime;
cvx_begin
 variable x1(n);
 minimize(norm(x1,1));
 A*x1 == b;
cvx_end
f_1 = norm(x1,1);
t_end1 = cputime;
% least-norm solution for the starting point

x2 = A.'*pinv(A*A.')*b;
k = 10000;
stepsize = 100/k; % Polyak estimated step size rule
fbest = zeros(1,k+1);
fbest(1,1) = norm(x2,1);
t_start2 = cputime;
for i = 1:1:k
 x2 = x2 - stepsize*(eye(n)-(A.'*pinv(A*A.')*A))*sign(x2);
 fbest(1,i+1) = min(fbest(1,i),norm(x2,1));
end
t_end2 = cputime;
tot_cputime = 0.28/(t_end1-t_start1)*(t_end2-t_start2);
figure(1)
plot(1:n,x,'ro',1:n,x1,'b*'), legend('original','recovery');
title('Comparison of recovery signal and original signal using 
CVX','FontSize',12)
xlabel('n','FontSize',10);
ylabel('value of x','FontSize',10);
axis([1 128 -0.2 1]);
grid on
figure(2)
plot(1:n,x,'r*',1:n,x2,'bo'), legend('original','recovery');
title('Comparison of recovery signal and original signal using projected 
subgradient method','FontSize',12)
xlabel('n','FontSize',10);
ylabel('value of x','FontSize',10);
axis([1 128 -0.2 1]);
grid on
fplot = fbest(1,1:k)-fbest(1,k+1);
figure(3)
title('Convergence of the projected subgradient method for a L1 norm 
problem','FontSize',15);
xlabel('number of iteration','FontSize',15);
ylabel('f_{best} - f*','FontSize',15);
axis([1 10000 10e-2 10]);
semilogy(fplot,'LineWidth',5);