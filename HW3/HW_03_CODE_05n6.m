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
t_f = 2*pi;
t = linspace(t_0,t_f,1000);

%x = x_0*exp(-w_n*t) + (v_0+x_0*w_n)*(t.*exp(-w_n*t));
x = exp(-w_n*t).*(x_0 + (v_0+x_0*w_n)*(t));
fig1 = figure;
plot(t,x)
xlabel('$t$', 'Interpreter','latex');
ylabel('$\theta(t)$', 'Interpreter','latex');
title('Critically Damped Response');
grid on;

v = exp(-w_n*t).*(-x_0*w_n + (v_0+x_0*w_n)*(-t*w_n + 1));
fig2 = figure;
plot(x,v)
xlabel('$\theta(t)$', 'Interpreter','latex');
ylabel('$\dot{\theta}(t)$', 'Interpreter','latex');
title('Critically Damped Phase Plane');
grid on;

%hello jaden