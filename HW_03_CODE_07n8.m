% HW_03_CODE_07 & 8.m
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

c2 = (v_0 + w_n*x_0*(2 - sqrt(3)))/(-2*w_n*sqrt(3));
c1 = x_0 - c2;
x = c1*exp(w_n*t*(-2+sqrt(3))) + c2*exp(w_n*t*(-2-sqrt(3)));
fig1 = figure;
plot(t,x)
xlabel('$t$', 'Interpreter','latex');
ylabel('$\theta(t)$', 'Interpreter','latex');
title('Overdamped Response');
grid on;

v = c1*(w_n*(-2+sqrt(3)))*exp(w_n*t*(-2+sqrt(3))) + c2*(w_n*(-2-sqrt(3)))*exp(w_n*t*(-2-sqrt(3)));
fig2 = figure;
plot(x,v)
xlabel('$\theta(t)$', 'Interpreter','latex');
ylabel('$\dot{\theta}(t)$', 'Interpreter','latex');
title('Overdamped Phase Plane');
grid on;

%hello jaden