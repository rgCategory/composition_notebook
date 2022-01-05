function y = airplaneODE(A, B, t, u)
    % Dependent variables: [state]
    y = A*u; 
    
    % Control Inputs: [time]
    y = y + B*funcDelta(t); 
    
    % Return y
end