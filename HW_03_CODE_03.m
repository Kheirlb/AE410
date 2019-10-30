% HW_03_CODE_03.m
% Authors: Karl Parks and Jaden Bowyer
% x = theta
% v = theta_dot
% w = omega

%clear; clc; close all;

x_0 = (2/180)*pi;
v_0 = -1/100;

w_n = 10;

t_0 = 0;
t_f = (3*pi)/(2*w_n);
t = linspace(t_0,t_f,1000);

phi = atan((4*v_0)/(-x_0*w_n*sqrt(15)) - 1/sqrt(15));
X = x_0/(cos(phi));
x = (exp((-w_n/4)*t) * X).*(cos(w_n*t*(sqrt(15)/4) + phi));
fig1 = figure;
plot(t,x)
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('$\theta(t)$ [rad]', 'Interpreter','latex');
title('Underdamped Response');
grid on;