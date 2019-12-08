close all;

A = 1;
phi = 0;
F0 = 40;
k = 1;
m = 10;

wn = sqrt(k/m);
w = wn*10;

x0 = 0;
x0dot = 1;

t = linspace(0,8*pi,1000);

X = F0/(k-m*(w^2));
C1 = x0-X;
C2 = (x0dot/wn);

x = C1*cos(wn*t) + C2*sin(wn*t) + X*cos(w*t);
xh = C1*cos(wn*t) + C2*sin(wn*t);
xp = X*cos(w*t);

fig1 = figure(1);
line1 = 2*pi;
plot(t,x);
hold on;
plot(t,xh);
plot(t,xp);
grid on;
val = 0.2;
ylim = [-val val];
%xlim([0 10]);
line([2*pi/w, 2*pi/w], ylim, 'Color','red');
line([2*pi/wn, 2*pi/wn], ylim, 'Color','blue');
legend("x - Total Solution","xh","xp - Particular Solution","2pi/w","2pi/wn");

fprintf("w/wn: %0.2f\n", w/wn);

%fig2 = figure(2);

