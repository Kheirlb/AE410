w_n = 10;

t_0 = 0;
t_f = (3*pi)/(2*w_n);
t_f = 2*pi;
t = linspace(t_0,t_f,1000);

HW_03_CODE_01;

x1 = x;
v1 = v;
HW_03_CODE_02;
x2 = x;
v2 = v;
HW_03_CODE_03;
x3 = x;
v3 = v;
HW_03_CODE_04;
x4 = x;
v4 = v;

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