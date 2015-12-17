function [c, ceq] = simpleConstraint(odf)

%This sets the simple constraints for the odf. In this case, the constraints are the constraints on the limits on the Torsional Frequency and the Bending Frequency
	data1 = load('constraints.mat');
	stiffness = data1.stiffness;


	stiffness_avg = reshape(stiffness*odf',6,6) ;
	S = inv(stiffness_avg);
	Ex = 1/S(1,1) ; %Average Young Modulus
	S66 = S(6,6);
	Gxy = 1/S66; % Shear modulus

	a = 3;
	b = 20;
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

	 c = [w1b-120;122.5-w1b;
	  w1t-19;21-w1t];
	 ceq = [];

