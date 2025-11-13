clc
clear

% Fitting Data to a Function
% Reading data
fname = 'PopulationData.xlxs';
if exist(fname,'file') ~= 2
    fname = 'PopulationData.xlsx';
end
A = xlsread(fname);
year = A(:,1);
pop = A(:,2);

% Creating x values
xfit = min(year):1:max(year)+30;

% Linear fit
pL = polyfit(year, pop, 1);
yL = polyval(pL, year);
SSres_L = sum((pop - yL).^2);
SStot = sum((pop - mean(pop)).^2);
R2_L = 1 - SSres_L / SStot;

% Power fit
lx = log(year);
ly = log(pop);
pP = polyfit(lx, ly, 1);
k = pP(1);
c = exp(pP(2));
yP = c * year.^k;
SSres_P = sum((pop - yP).^2);
R2_P = 1 - SSres_P / SStot;

% Exponential fit
pE = polyfit(year, log(pop), 1);
B = pE(1);
A0 = exp(pE(2));
yE = A0 * exp(B * year);
SSres_E = sum((pop - yE).^2);
R2_E = 1 - SSres_E / SStot;

% R^2 comparison
R2s = [R2_L, R2_P, R2_E];
best = 1;
if R2_P > R2s(best)
    best = 2;
elseif R2_E > R2s(best)
    best = 3;
end

% Plotting
subplot(1,3,1)
plot(year, pop, 'o')
grid on
title('linear')
xlabel('Year')
ylabel('Population')

subplot(1,3,2)
loglog(year, pop, 'o')
grid on
title('loglog')
xlabel('Year')
ylabel('Population')

subplot(1,3,3)
semilogy(year, pop, 'o')
grid on
title('semilogy')
xlabel('Year')
ylabel('Population')

% Overlaying best fit
if best == 1
    m = pL(1);
    b = pL(2);
    yfit = polyval(pL, xfit);
    subplot(1,3,1)
    hold on
    plot(xfit, yfit, 'LineWidth', 1.5)
    hold off
    modelType = 'linear';
    if b >= 0
        modelStr = sprintf('y = %.6g*x + %.6g', m, b);
    else
        modelStr = sprintf('y = %.6g*x - %.6g', m, -b);
    end
elseif best == 2
    yfit = c * xfit.^k;
    subplot(1,3,2)
    hold on
    loglog(xfit, yfit, 'LineWidth', 1.5)
    hold off
    modelType = 'power';
    modelStr = sprintf('y = %.6g*x^{%.6g}', c, k);
else
    yfit = A0 * exp(B * xfit);
    subplot(1,3,3)
    hold on
    semilogy(xfit, yfit, 'LineWidth', 1.5)
    hold off
    modelType = 'exponential';
    modelStr = sprintf('y = %.6g*e^{%.6g*x}', A0, B);
end

% Prediction
yrPred = 2050;
if best == 1
    y2050 = polyval(pL, yrPred);
elseif best == 2
    y2050 = c * yrPred^k;
else
    y2050 = A0 * exp(B * yrPred);
end
bill = y2050 / 1e9;

% Output
fprintf('\nThis data fits best to a %s function, described by\n' ...
    , modelType)
fprintf('%s.\n', modelStr)
fprintf(['\nThe predicted world population in %d is %.4g ' ...
    '    (or %.1f billion).\n'], yrPred, y2050, bill)

