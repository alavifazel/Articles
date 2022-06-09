pkg load symbolic

syms t y

phi0 = t^2
phi1 = t^2 + 3*t^3

t_phi0 = (t^5 + 5*t)/(5) - (42)/(5)
t_phi1 = (45*t^7 + 35*t^6 + 7*t^5 + 35*t)/(35) - (8294)/(35)

set(groot,'defaultLineLineWidth',1.8)

p = ezplot(phi0)
set(p, 'Color', 'b');
hold on
p2 = ezplot(phi1)
set(p2, 'Color', 'b');
hold on
p3 = ezplot(t_phi0)
set(p3, 'Color', 'r');
hold on
p4 = ezplot(t_phi1)
set(p4, 'Color', 'r');
hold on

waitfor(p)
