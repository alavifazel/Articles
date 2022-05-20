pkg load symbolic

syms t y

phi0 = 3
phi1 = (t^2+6*t)/2 - 5
phi2 = (t^3+12*t^2-30*t)/6 + 11/3
phi3 = (t^4+16*t^3-48*t^2+88*t)/24 - 7/3

set(groot,'defaultLineLineWidth',1.8)

line([-100,100],[3,3])
hold on
ezplot(phi1)
hold on
ezplot(phi2)
hold on
p = ezplot(phi3)
hold on

waitfor(p)
