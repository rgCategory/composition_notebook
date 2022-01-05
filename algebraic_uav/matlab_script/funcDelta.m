function d = funcDelta(t)
    % Time dependant control input:
    D_PULSE = 0.05;
    T_PULSE = 0;
    
    len = length(t);
    d = zeros(len,1);
    
	% Step input
    for i = 1:len
        if t(i) < T_PULSE
            d(i) = 0;
        else
            d(i) = D_PULSE;
        end
    end
    % Return d
end

