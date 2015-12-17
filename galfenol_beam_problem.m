% Galfenol Beam Vibration Tuning Problem
% 17September 2015
clear all; clc;

load property_data.mat % Galfenol property matrix
stiffness = c_m; % Stiffness parameters
volumefraction = c1;  % Volume fraction

odf = zeros(76,1); % 76 independent ODF parameters 

% An example ODF case (not optimum)
p = 1; 
odf(p) = 1/volumefraction(1,p);

% Computation of Structural Parameters
C = reshape(stiffness*odf,6,6);  % Elastic stiffness matrix
S = inv(C); % Compliance matrix
S1111 = S(1,1);
Ex = 1/S1111; % Young's modulus
S66 = S(6,6);
Gxy = 1/S66; % Shear modulus
% Yield Stress
load('linprog_a_yield.mat');
f1 = y; %yield stress data
yield_stress = f1'*odf;  % Yield stress averaging

% Geometric Properties of the Beam
%a = 0.003;  % cross-section length
%b = 0.02; % cross-section width
a = 3;
b = 20;a
L = 0.45; % length of the beam

I = (b*(a^3))/12; % moment of inertia in longitidunal direction
% Torsion constant needs iteration
beta1 = 0.299;
beta2 = 0.312;
r1 = 6;
r2 = 10;
r = 6.67;
rat = (10-r)/(r-r1);
beta = (beta2+(beta1*rat))/(rat+1);
J = beta*a*(b^3); % torsion constant for natural frequency

% Inertia moment computation
Iy = (a*(b^3))/12;
Ix = (b*(a^3))/12;
mass = 5; % kg mass
Ip = Ix + Iy;  % Polar moment of inertia
A = a*b;  % Area of the rectangle cross-section
rhop = mass/(A*L);  % Mass per unit volume


% Bending Frequency Equations
alphaL = 1.87510;
w1b = ((alphaL^2)*sqrt((Ex*Ix)/(mass*(L^4))))/(2*pi);  % 1st bending frequency in Hz

% Torsional Frequency Equations
w1t = ((pi/(2*L))*sqrt((Gxy*J)/(rhop*Ip)))/(2*pi);  % 1st torsional frequency in Hz