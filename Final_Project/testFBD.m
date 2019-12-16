% testing for FBD
clear; clc; close all;
% random test case
a = 3;
d = 2;
syms t
th1_t = 3*t^2;
th2_t = 2*t;

% From Assignment 3 
w1 = 2.0706;
w2 = 4.4384;
r1 = 3.4727;
r2 = -3.0441;
bth1_1 = 0.0178;
bth2_1 = 0.0619;
bth1_2 = 0.0071;
bth2_2 = -0.0217;
phi1 = 0.9089;
phi2 = 0.0338;
C1 = sqrt(3);
C2 = sqrt(5);

th1_t = C1*bth1_1*cos(w1*t + phi1) + C2*bth1_2*cos(w2*t + phi2);
th2_t = C1*bth2_1*cos(w1*t + phi1) + C2*bth2_2*cos(w2*t + phi2);

th1d_t = diff(th1_t);
th1dd_t = diff(th1d_t);

th2d_t = diff(th2_t);
th2dd_t = diff(th2d_t);

% geometric approach
% x
Px_t = a*cos(th1_t) + d*cos(th2_t);
Vx_t = diff(Px_t);
Ax_t = diff(Vx_t);
Ax_t_geo = Ax_t;

% y
Py_t = -a*sin(th1_t) - d*sin(th2_t);
Vy_t = diff(Py_t);
Ay_t = diff(Vy_t);

totalTime = 5;
numpoints = 100;
t0 = linspace(0,totalTime,numpoints);
%t0 = 0;
Ax_t0_geo = double(simplify(subs(Ax_t, t, t0)));
Ax_t0_geo

% kinematic approach
Ax_t_kin = a*th1dd_t*sin(th1_t) + d*th2dd_t*sin(th2_t) + d*(th2d_t^2)*cos(th2_t) + a*(th1d_t^2)*cos(th1_t);
Ax_t0_kin = double(simplify(subs(Ax_t_kin, t, t0)));
Ax_t0_kin

accelFig = figure();
plot(t0, Ax_t0_geo);
hold on;
grid on;
xlabel('Time');
ylabel('X Acceleration');
title('X Acceleration of G2');
plot(t0,Ax_t0_kin);
legend('Geometric Accel','Kinematic [Inertial] Accel');

%% Position Figiure
Px_t0 = double(simplify(subs(Px_t, t, t0)));
Py_t0 = double(simplify(subs(Py_t, t, t0)));
posFig = figure();
h = animatedline;
axis([-5,5,-5,5]);
grid on;
title('Position of G2');
xlabel('X Pos');
ylabel('Y Pos');
a = tic; % start timer
for k = 1:numpoints
    xvec = Px_t0(k);
    yvec = Py_t0(k);
    addpoints(h,xvec,yvec)
    b = toc(a); % check timer
    while b < totalTime/numpoints
        %disp('did it do anything');
        drawnow % update screen every 1/30 seconds
        b = toc(a); % check timer
    end
    a = tic; % reset timer after updating    
    disp(k);
end
drawnow;

% plot3(Px_t0,Py_t0,t0);
% grid on
% zlabel('Time');
% ylabel('X Position');
% xlabel('Y Position');