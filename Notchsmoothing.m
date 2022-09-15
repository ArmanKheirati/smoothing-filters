function [x, cost] = Notchsmoothing(y, fN, lam, flag);
% [x, cost] = Notchsmoothing(y, fN, lam, flag);
%
% INPUT
% y - noisy signal
% lam - regularization parameter
% flag - use 1 for fast computation 
%
% OUTPUT
% x - denoised signal
% cost - cost function history
%
% Reference
y = y(:); % Make column vector
N = length(y);
wN = 2*pi*fN;
I = speye(N);
D = I(1:N-2, :) - 2*cos(wN)*I(2:N-1, :) + I(3:N,:);
x = y; % Initialization
Dx = D*x;
Dy = D*y;
DDT = D * D';
if flag == 0
    F = eye(N) + lam*D'*D; % F : Sparse banded matrix
    x = F\y; % Solve banded linear system
    cost = 0.5*sum(abs(x-y).^2) + lam*sum(abs(D*x)); % cost function value
else 
    F = sparse(1:N-2, 1:N-2, abs(Dx)/lam) + DDT; % F : Sparse banded matrix
    x = y - D'*(F\Dy); % Solve banded linear system
    cost = 0.5*sum(abs(x-y).^2) + lam*sum(abs(D*x)); % cost function value
end
x = x';
