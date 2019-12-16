% Part 2 Assignment 5
% Description: Calculates the Frequencies and Modes of a 2 DoF Dynamic
% System. Uses initial conditions and plots the solution over a given time
% interval. Also includes an animation of the motion for a simplified
% non-linear wing-aileron model.

% Class: AE 410 Vibrations
% Assignment: Final Project - Part 2 Assignment 5
% Authors: Karl Parks, Jaden Boywer, Dylan Shaffer, Walker Davidson, Roelle Nogra
% Date: 12/12/2019

% USER: Input Matrices are in the Following Section after the Symbolics

% Disclaimer: This code was developed originally for a 2 DoF non-linear
% model and therefore most of the notation is expressed using the greek
% letter theta to represent changes in angle. Nearly all of the the .m
% script will still work for linear motion.

% MATLAB R2018a or newer and the Symbolic Math Toolbox are required.

clear; clc; close all;

%% Symbolic Definitions required for Assignment 3
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

alpha = 10;
beta = 4;
gamma = 2;
sphi = 5;
kB = k; % 0 for Assignment 4
kA = alpha*k; % k for Assignment 4
a = beta*d;
c = a/4;
m1 = 4*m2;
IGail = gamma*m2*d^2;
IGw = sphi*IGail;

%% Input Matrices
% input mass matrix
M = [IGw + m1*c^2 + m2*a^2, m2*a*d;
     m2*a*d               , IGail + m2*d^2];    

% input stiffness matrix     
K = [kA + kB, -kB;
     -kB    ,  kB];

% additional example matrices below, uncomment to use
% input mass matrix
% M = [10 0
%      0  4];    
% 
% % input stiffness matrix     
% K = [3 2
%      2 4];

%% Beginning Calculations
combinedM = -w^2*M + K; %combined matrix -> frequency matrix

% show matrices
M
K
combinedM

detW2 = det(combinedM); %frequency equations
syms temp
detTemp = subs(detW2, [w^4 w^2], [temp^2, temp]);
solveDet = solve(detTemp); % solve quadratic equation
wTemp = double(simplify(subs(solveDet, m2*d^2, k/25)));
if abs(sqrt(wTemp(1))) < abs(sqrt(wTemp(2))) %smaller omega for mode 1
    w1 = sqrt(wTemp(1));
    w2 = sqrt(wTemp(2));
else
    w1 = sqrt(wTemp(2));
    w2 = sqrt(wTemp(1));
end

% show w values
fprintf('Omega1: %2.4f\n',w1);
fprintf('Omega2: %2.4f\n',w2);

%% Amplitude Ratios
r = -combinedM(2,1)/combinedM(2,2);
r = simplify(subs(r, m2*d^2, k/25));
r1 = double(simplify(subs(r,w,w1)));
r2 = double(simplify(subs(r,w,w2)));

% show r values
fprintf('r1: %2.4f\n',r1); 
fprintf('r2: %2.4f\n',r2); 

%% Display Modes (without initial conditions applied)

digits(4);
syms bth1_1 bth1_2 t phi_1 phi_2

fprintf('\nMode 1:\n');
disp([bth1_1; vpa(r1)*bth1_1]*cos(vpa(w1)*t + vpa(phi_1)));

fprintf('Mode 2:\n');
disp([bth1_2; vpa(r2)*bth1_2]*cos(vpa(w2)*t + vpa(phi_2)));

%% Initial Conditions: Amplitudes and Phase Angles
% th1_t = equation of motion for theta_1
% th1_0 = theta_1 position inital condition
% th1d_0 = theta_1_dot velocity inital condition
% bth1_1 = big_theta_1 (1)
% bth2_1 = big_theta_2 (2)
% phi1 = phi_1
% w1 = omega_1
% r1 = ratio_1

th1_0 = 2*pi/180;
th2_0 = 1*pi/180;

th1d_0 = (-3*pi)/(2*180);
th2d_0 = (-5*pi)/180;

C1 = sqrt(3);
C2 = sqrt(5);
% C1 = 1;
% C2 = 1;

% Original Amplitudes (No Normalization)
% bth1_1 = (1/(r2-r1))*sqrt((r2*th1_0 - th2_0)^2+(-r2*th1d_0 + th2d_0)^2/w1^2);
% bth2_1 = r1*bth1_1;
% bth1_2 = (1/(r2-r1))*sqrt((r1*th1_0 - th2_0)^2+(-r1*th1d_0 + th2d_0)^2/w2^2);
% bth2_2 = r2*bth1_2;

% Normalized Amplitudes
temp1 = ((th1_0/C1)-((th2_0 - r1*th1_0)/(C1*(r2-r1))))^2;
temp2 = ((-th1d_0/(w1*C1))-((th2d_0 - r1*th1d_0)/(w1*C1*(r1-r2))))^2;
bth1_1 = sqrt(temp1 + temp2);
bth1_2 = sqrt(((th2_0 - r1*th1_0)/(C2*(r2-r1)))^2 + ((th2d_0 - r1*th1d_0)/(C2*(r1-r2)))^2);

if isinf(bth1_1) == 1
    disp('Can Not Continue');
    return;
end

bth2_1 = r1*bth1_1;
bth2_2 = r2*bth1_2;

fprintf('Big Theta1(1): %2.4f\n',bth1_1);
fprintf('Big Theta2(1): %2.4f\n',bth2_1);
fprintf('Big Theta1(2): %2.4f\n',bth1_2);
fprintf('Big Theta2(2): %2.4f\n',bth2_2);

% Original Phase Angles (No Normalization)
% phi1 = atan((-r2*th1d_0 + th2d_0)/(w1*(r2*th1_0 - th2_0)));
% phi2 = atan((r1*th1d_0 - th2d_0)/(w2*(-r1*th1_0 + th2_0)));

% Normalized Phase Angles
phi1 = acos((th1_0/(bth1_1*C1)) - ((th2_0 - r1*th1_0)/(bth1_1*C1*(r2-r1))));
phi2 = acos((th2_0 - r1*th1_0)/(bth1_2*C2*(r2-r1)));

fprintf('Phi 1: %2.4f rad, %2.4f deg\n',phi1,phi1*180/pi);
fprintf('Phi 2: %2.4f rad, %2.4f deg\n',phi2,phi2*180/pi);

%% Display Modes (normalization applied with initial conditions)

fprintf('\nMode 1:\n');
disp([vpa(bth1_1); vpa(r1)*vpa(bth1_1)]*cos(vpa(w1)*t + vpa(phi1)));

fprintf('Mode 2:\n');
disp([vpa(bth1_2); vpa(r2)*vpa(bth1_2)]*cos(vpa(w2)*t + vpa(phi2)));

%% Begin Plot Work
totalTime = 50; %seconds, adjust here
numOfSteps = totalTime*20; %20 steps per second
t = linspace(0,totalTime,numOfSteps);

% Expression for theta_1(t) and theta_2(t) using superposition of modes.
th1_t = C1*bth1_1*cos(w1*t + phi1) + C2*bth1_2*cos(w2*t + phi2);
th2_t = C1*bth2_1*cos(w1*t + phi1) + C2*bth2_2*cos(w2*t + phi2);

fprintf('Initial Val\t== Evaluated @ t(0)\n');
fprintf('%0.4f \t\t== %0.4f\n',th1_0, th1_t(1));
fprintf('%0.4f \t\t== %0.4f\n',th2_0, th2_t(1));

assignmentFig = figure();
plot(t,th1_t);
hold on;
grid on;
plot(t,th2_t);
xlabel('Time [s]');
ylabel('Amplitude');
title('Solution of Part 2 - Assignment 3 & 5');
legend('theta1(t)','theta2(t)');

%% Begin Animation Work (only applies to non-linear motion)
% Will this get us some extra points for going above and beyond???
% Thanks Demasi!!!

percentageOfTime = 0.1; % animation time (avoiding 50 seconds)
speedFactor = 1; % scale playback speed
angleScale = 1; % show extreme motion
titleName = 'Dynamic Motion Animation: ' + string(floor(totalTime*percentageOfTime)) + ' Seconds';
fprintf('\nStarting and running animation... please wait ~ %0.0f seconds.\n', floor(totalTime*percentageOfTime));

centerWing = [0 0]; %[x y] coordinate
l1 = 3; % arbitrary values for wing length
l2 = 1; % arbitrary values for aileron length
Bx = [centerWing(1) 0]; % x vec for point B (end of wing)
By = [centerWing(2) 0];
Cx = [Bx(2) 0]; % x vec for point C (end of alieron)
Cy = [By(2) 0];

% circular motion
thCircle = linspace(0,2*pi,500);
rCircle = l1;
xCircle = centerWing(1)+rCircle*cos(thCircle);
yCircle = centerWing(1)+rCircle*sin(thCircle);
rCircle2 = l2;

animationFig = figure();
wing = plot(Bx,By,'-o');
grid on;
hold on;
aileron = plot(Cx,Cy,'-*');
plot(xCircle, yCircle, ':k');
plotCircle2 = plot(xCircle, yCircle, ':k');

xlabel('X Position');
ylabel('Y Position');
title(titleName);
legend('Wing', 'Aileron');
Amark = text(centerWing(1),centerWing(2),'A  ','HorizontalAlignment','right');
Bmark = text(Bx(2),By(2),'  B');
Cmark = text(Cx(2),Cy(2),'  C');
timeSpotx = -0.75;
timeMark = text(timeSpotx,1.25,'Current Time: ');

axis equal;
axis([-1 5 -1.5 1.5]);
a = tic; % start timer
for i = 1:floor(numOfSteps*percentageOfTime)
    % calculate position of point B
    Bx(2) = centerWing(1) + cos(th1_t(i)*angleScale)*l1;
    By(2) = centerWing(2) + sin(th1_t(i)*angleScale)*l1;
    % start position of point C (at B)
    Cx(1) = Bx(2);
    Cy(1) = By(2);
    % calculate position of point C
    Cx(2) = Bx(2) + cos(th2_t(i)*angleScale)*l2;
    Cy(2) = By(2) + sin(th2_t(i)*angleScale)*l2;
    
    delete(Bmark);
    delete(Cmark);
    delete(timeMark);
    set(wing,'XData',Bx,'YData',By);
    Bmark = text(Bx(2),By(2),'  B');
    set(aileron,'XData',Cx,'YData',Cy);
    Cmark = text(Cx(2),Cy(2),'  C');
    xCircle2 = Bx(2)+rCircle2*cos(thCircle);
    yCircle2 = By(2)+rCircle2*sin(thCircle);
    set(plotCircle2,'XData',xCircle2,'YData',yCircle2);
    
    insertTime = 'Current Time: ' + string(floor((i/numOfSteps)*totalTime)) + ' Seconds'; 
    timeMark = text(timeSpotx,1.25,insertTime);

    b = toc(a); % check timer
    while b*speedFactor < ((totalTime)/(numOfSteps))
        drawnow % update screen
        b = toc(a); % check timer
    end
    a = tic; % reset timer after updating  
end
drawnow;

% End of Code
fprintf('\nEnd of Code - Scroll up for more information.\n');
