% EE4530 Applied Convex Optimisation Project 5

clc
clear all
load('cs.mat')              % load data

% z = ones(1,128);
n = 128;
m = n/4;
freq = find(sampling_mask);
A = [real(F_us(freq,:)); 
     imag(F_us(freq,:))]; 
 
X_us(find(X_us==0))=[];

b = [real(X_us); 
     imag(X_us)];       % b = A*x;


% cvx_quiet(true);

cvx_begin
    variable x1(n);
    minimize(norm(x1,1));
    A*x1 == b;
cvx_end

% norm(x1 - x)/norm(x)
figure, plot(1:n,x,'bo',1:n,x1,'r*'), legend('original','decoded')



% X_us(find(X_us==0))=[];

% x1 = zeros(128,1);

% X_us(find(X_us==0))=[];
% A = X_us;
% b = A./x;


% theta = x'*X_us;

% cvx_begin
%     variable t(n)
%     minimize( z*t )
%     subject to
%         x <= t;
%         x >= -t;
% %         X_us = F_us*x;
% cvx_end
% 
% figure
% subplot(2,1,1); plot(x);
% subplot(2,1,2); plot(t);



% cvx_begin
%     variable x1(n)
%     minimize( norm(x1,1) )
%     subject to
%         X_us = F_us*x1;
% cvx_end


% idx_Xus = X_us == 0;
% K_Xus = n-sum(idx_Xus(:));          % X_us is 32-sparse
% 
% idx_x = x == 0;
% K_x = n-sum(idx_x(:));              % x is 5-sparse

% m = 16; n = 8;
% A = randn(m,n);
% b = randn(m,1);
% 
% x_ls = A \ b;
% 
% cvx_begin
%     variable t(n)
%     minimize( norm(x,1) )
%     subject to
%         X_us = F_us*x;
% cvx_end

% 
% bnds = randn(n,2);
% l = min( bnds, [], 2 );
% u = max( bnds, [], 2 );
% 
% cvx_begin
%     variable x(n)
%     minimize( norm(A*x-b) )
%     subject to
%         l <= x <= u
% cvx_end


