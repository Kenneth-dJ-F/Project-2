
clc
clear

% Non-uniform charged rod: potential along y-axis
% Inputs
fprintf('Preset options:\n')
fprintf('1) L=1 m, lambda0=1e-6 C/m\n')
fprintf('2) L=0.5 m, lambda0=5e-7 C/m\n')
fprintf('3) Custom\n')
opt = input('Choose 1-3: ');
if opt == 1
    L = 1; lambda0 = 1e-6;
elseif opt == 2
    L = 0.5; lambda0 = 5e-7;
else
    L = input('Enter rod half-length L (m): ');
    lambda0 = input('Enter lambda0 (C/m): ');
end

% Constants
eps0 = 8.854e-12;
k = 1/(4*pi*eps0);

% Rod discretization
Nrod = 200;
dx = (2*L)/Nrod;
xi = -L + dx/2 : dx : L - dx/2;

% Charge density and dq
lam = lambda0*(1 - (xi./L).^2);
i = 1;
while i <= Nrod
    if lam(i) < 0
        lam(i) = 0;
    end
    i = i + 1;
end
dq = lam*dx;
Qtot = 0;
i = 1;
while i <= Nrod
    Qtot = Qtot + dq(i);
    i = i + 1;
end

% Potential along y-axis (x=0)
rmax = 3*L;
dr = 0.05*L;
rvals = -rmax:dr:rmax;
Nvals = (2*rmax)/dr + 1;
Vaxis = zeros(1,Nvals);
i = 1;
while i <= Nvals
    y = rvals(i);
    Vtemp = 0;
    n = 1;
    while n <= Nrod
        rx = 0 - xi(n);
        ry = y;
        r = sqrt(rx^2 + ry^2);
        if r < 0.25*dx
            r = 0.25*dx;
        end
        Vtemp = Vtemp + k*dq(n)/r;
        n = n + 1;
    end
    Vaxis(i) = Vtemp;
    i = i + 1;
end

% Plot potential
plot(rvals,Vaxis,'b')
grid on
title('Potential along y-axis (x=0)')
xlabel('y (m)')
ylabel('V (V)')

% Outputs
fprintf('\n--- Results ---\n')
fprintf('L = %.3f m\n', L)
fprintf('lambda0 = %.3e C/m\n', lambda0)
fprintf('Total charge Qtot = %.3e C\n', Qtot)
fprintf('Max potential on plot = %.3e V\n', max(Vaxis))
