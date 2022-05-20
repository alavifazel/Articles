% To use symbolic library, install sympy version 1.5.1
% with 'pip3 install sympy==1.5.1'
pkg load symbolic

syms x y
f = x + 3
phi1 = 3 + int(f, x);
phi2 = 3 + int(x + phi1, x);

p1 = ezplot(phi1)
hold on

global phi_n
phi_n = phi1

for i = 1:5
    phi_n_plus_1 = 3 + int(phi_n, x)
    ezplot(phi_n_plus_1)
    phi_n = phi_n_plus_1
end


waitfor(p1)
