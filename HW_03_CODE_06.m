% HW_03_CODE_06.m
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

v = exp(-w_n*t).*(-x_0*w_n + (v_0+x_0*w_n)*(-t*w_n + 1));
fig2 = figure;
plot(x,v)
xlabel('$\theta(t)$ [rad]', 'Interpreter','latex');
ylabel('$\dot{\theta}(t)$ [rad/s]', 'Interpreter','latex');
title('Critically Damped Phase Plane');
grid on;