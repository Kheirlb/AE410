% HW_03_CODE_01.m
% Authors: Karl Parks and Jaden Bowyer
% x = theta
% v = theta_dot
% w = omega

clear; clc; close all;

x_0 = (2/180)*pi;
v_0 = -1/100;

w_n = 10;

t_0 = 0;
t_f = (3*pi)/(2*w_n);
t_f = 2*pi;
t = linspace(t_0,t_f,1000);

x = (sqrt(x_0 + (v_0/w_n)^2)) * sin(w_n*t + atan((x_0*w_n)/v_0));
fig1 = figure;
plot(t,x)
xlabel('$t$', 'Interpreter','latex');
ylabel('$\theta(t)$', 'Interpreter','latex');
title('Undamped Response');
grid on;

v = w_n*(sqrt(x_0 + (v_0/w_n)^2)) * cos(w_n*t + atan((x_0*w_n)/v_0));
fig2 = figure;
plot(x,v)
xlabel('$\theta(t)$', 'Interpreter','latex');
ylabel('$\dot{\theta}(t)$', 'Interpreter','latex');
title('Undamped Phase Plane');
grid on;

%hello jaden