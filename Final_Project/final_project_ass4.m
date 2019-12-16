% Part 2 Assignment 3 (&5) & 4
clear; clc; close all;

% m1 = mass_1
% m2 = mass_2
% c = distance c
% d = distance d
% a = distance a
% IGw = I_G^wing
% IGail = I_G^aileron
% kA = k_A
% kB = k_B

% sphi = small phi
% w = omega

syms m1 m2 c d a IGw IGail kA kB 
syms k alpha beta gamma sphi w

%% Assignment 4
alpha = 10;
beta = 4;
gamma = 2;
sphi = 5;
kB = 0; %different than assignment 3
kA = k; %different than assignment 3
a = beta*d;
c = a/4;
m1 = 4*m2;
IGail = gamma*m2*d^2;
IGw = sphi*IGail;

massM = [IGw + m1*c^2 + m2*a^2, m2*a*d;
         m2*a*d,                IGail + m2*d^2];

stiffM = [kA + kB,  -kB;
          -kB,      kB];

combinedM = -w^2*massM + stiffM;

% show matrices
massM
stiffM
combinedM

detW2 = det(combinedM);
syms temp
detTemp = subs(detW2, [w^4 w^2], [temp^2, temp]);
solveDet = solve(detTemp);
wTemp = double(simplify(subs(solveDet, m2*d^2, k/25)));
if abs(sqrt(wTemp(1))) < abs(sqrt(wTemp(2)))
    w1 = sqrt(wTemp(1));
    w2 = sqrt(wTemp(2));    
else
    w1 = sqrt(wTemp(2));    
    w2 = sqrt(wTemp(1));    
end

% show w values
fprintf('Omega1: %2.4f\n',w1); 
fprintf('Omega2: %2.4f\n',w2); 

%% Amplitude Ratios and Phase Angles
r = -combinedM(2,1)/combinedM(2,2);
r = simplify(subs(r, m2*d^2, k/25));
r
simplify(subs(r,w,w2))
r2 = double(simplify(subs(r,w,w2)));
simplify(subs(r,w,w2))
r1 = double(simplify(subs(r,w,w1)));

% show r values
fprintf('r1: %2.4f\n',r1);
fprintf('r2: %2.4f\n',r2);

% th1_t = equation of motion for theta_1
% th1_0 = theta_1 position inital condition
% th1d_0 = theta_1_dot velocity inital condition
% bth1_1 = big_theta_1 (1)
% bth2_1 = big_theta_2 (2)
% phi1 = phi_1
% w1 = omega_1
% r1 = ratio_1

% End of Code;
