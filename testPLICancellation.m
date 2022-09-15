clc, clearvars, close all;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load('SampleECG2.mat');
% data = data(:,2:end)';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('twa00m.mat');
fs = 1000;
data = val(1,:)/1000;

N = length(data);
t = (0 : N-1)/fs;
fc = 50;
wc = 2*pi*fc/fs;
Amp = sin(2*pi*0.1*t);
Amp = 1;
x_n  = 0.1*Amp.*cos(2*pi*fc*t);
xNoisy = data + x_n;
lam = 1e1;
flag = 1;
[x, cost] = Notchsmoothing(xNoisy, fc, lam, flag);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure, hax=axes;
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 15, 5], 'PaperUnits', 'Inches', 'PaperSize', [15, 5])
hold on
% Defaults for this blog post
width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 11;      % Fontsize
lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize
pos = get(gcf, 'Position');
% set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
box, grid
plot(data), hold all, plot(xNoisy)
legend('Clean data', 'Noisy data')

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure, hax=axes;
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 15, 5], 'PaperUnits', 'Inches', 'PaperSize', [15, 5])
hold on
% Defaults for this blog post
width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 11;      % Fontsize
lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize
pos = get(gcf, 'Position');
% set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
box, grid
plot(data), hold all, plot(x)
legend('Clean data', 'Denoised data')