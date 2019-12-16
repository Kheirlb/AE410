% Part 2 Assignment 5
clear; clc; close all;

% all inputs must be real numbers
% mass matrix input
M = [3, 0.5;
     0.5, 6];

% stiffness matrix input
K = [10, -3;
     -3, 5];

% w = omega
syms w
combinedM = -w^2*M + K;

detW2 = det(combinedM);
% temp = temporary variable

syms temp
detTemp = subs(detW2, [w^4 w^2], [temp^2, temp]);
solveDet = solve(detTemp);
wTemp = double(simplify(solveDet));
if abs(sqrt(wTemp(1))) < abs(sqrt(wTemp(2)))
    w1 = sqrt(wTemp(1));
    w2 = sqrt(wTemp(2));
else
    w1 = sqrt(wTemp(2));
    w2 = sqrt(wTemp(1));
end

% show frequencies values
fprintf('Omega1: %2.4f\n',w1); 
fprintf('Omega2: %2.4f\n',w2); 

%% Amplitude Ratios and Phase Angles
r = -combinedM(2,1)/combinedM(2,2);
r = simplify(r);
r1 = double(simplify(subs(r,w,w1)));
r2 = double(simplify(subs(r,w,w2)));

% show r values
fprintf('r1: %2.4f\n',r1); 
fprintf('r2: %2.4f\n',r2); 


