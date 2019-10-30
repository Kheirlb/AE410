% HW_03_CODE_05.m
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

x = exp(-w_n*t).*(x_0 + (v_0+x_0*w_n)*(t));
fig1 = figure;
plot(t,x)
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('$\theta(t)$ [rad]', 'Interpreter','latex');
title('Critically Damped Response');
grid on;