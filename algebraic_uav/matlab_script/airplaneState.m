% Description: Script to solve pitch attitude of airplane

%-- Input parameters:
T1   = 0;           % Inital time
T2   = 20;          % Final time
    % Initial values:
A_0 = 0;            % Angle of attack
Q_0 = 0;            % Angular velocity
O_0 = 0.0;          % Pitch angle

%-- State space model:

% State matrix
A = [-0.313 , 56.7  , 0;    ... 
     -0.0139,-0.426 , 0;    ...
      0     , 56.7  , 0];

% Control Input
B = [0.232; 0.0203; 0];

%{
% State space model requires Controls Toolbox (library)    
C = [0 0 1];
D = [0];
pitch_ss = ss(A,B,C,D)
%}

%-- Solve Equation:
func = @(t, u) airplaneODE(A, B, t, u);

[t, y] = ode45( func, [T1 T2], [A_0; Q_0; O_0] );

%-- Plot Results
plot(t, y(:,1) );        % Angle of attack
hold on;
plot(t, y(:,2)*1e2 );    % Angular velocity
plot(t, y(:,3) );        % Pitch angle [ Rel. Horizontal X-axis ]
    %
plot(t, funcDelta(t) )   % Control input
hold off;

    % Labels
legend( "AoA", "AngVel * 1e3", "Pitch angle", "Control input" ); 
xlabel( "time parameter" );
ylabel( "Response" );
title( "Aircraft Pitch behaviour" );

