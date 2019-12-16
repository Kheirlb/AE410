% overlayPlots.m
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

phi = atan(x_0 * w_n/v_0);
X = x_0/sin(phi);
x1 = X * sin(w_n*t + phi);
v1 = X * w_n * cos(w_n*t + phi);

phi = atan((4*v_0)/(-x_0*w_n*sqrt(15)) - 1/sqrt(15));
X = x_0/(cos(phi));
x2 = (exp((-w_n/4)*t) * X).*(cos(w_n*t*(sqrt(15)/4) + phi));
v2 = (-exp(-w_n*t/4)*X*w_n*sqrt(15)/4) .* sin(w_n*t*sqrt(15)/4 + phi) - (exp(-w_n*t/4)*X*w_n/4) .* cos(w_n*t*sqrt(15)/4 + phi);

x3 = exp(-w_n*t).*(x_0 + (v_0+x_0*w_n)*(t));
v3 = exp(-w_n*t).*(-x_0*w_n + (v_0+x_0*w_n)*(-t*w_n + 1));

c2 = (v_0 + w_n*x_0*(2 - sqrt(3)))/(-2*w_n*sqrt(3));
c1 = x_0 - c2;
x4 = c1*exp(w_n*t*(-2+sqrt(3))) + c2*exp(w_n*t*(-2-sqrt(3)));;
v4 = c1*(w_n*(-2+sqrt(3)))*exp(w_n*t*(-2+sqrt(3))) + c2*(w_n*(-2-sqrt(3)))*exp(w_n*t*(-2-sqrt(3)));

close all;
plot(x1,v1);
hold on;
plot(x2,v2);
plot(x3,v3);
plot(x4,v4);
legend('0','Under','1','Over');
xlabel('$\theta(t)$', 'Interpreter','latex');
ylabel('$\dot{\theta}(t)$', 'Interpreter','latex');
title('Phase Plane');
grid on;