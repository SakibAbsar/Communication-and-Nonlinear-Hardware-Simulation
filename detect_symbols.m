function [c_hat] = detect_symbols(d_hat, switch_mod, switch_graph)

M = 16;         % modulation order
K = log2(M);    % Number of bits per symbol

if switch_mod == 1 % To use 16 PSK modulation 
    
    constellation_points = [cosd(0)+1i*sind(0);cosd(337.5)+1i*sind(337.5);cosd(292.5)+1i*sind(292.5);cosd(315)+1i*sind(315);cosd(202.5)+1i*sind(202.5);
    cosd(225)+1i*sind(225);cosd(270)+1i*sind(270);cosd(247.5)+1i*sind(247.5);cosd(22.5)+1i*sind(22.5);cosd(45)+1i*sind(45);cosd(90)+1i*sind(90);
    cosd(67.5)+1i*sind(67.5);cosd(180)+1i*sind(180);cosd(157.5)+1i*sind(157.5);cosd(112.5)+1i*sind(112.5);cosd(135)+1i*sind(135)]; 
    % Constellation points for 16-PSK modulation 
            
else % To use 16 QAM modulation
    
    constellation_points = sqrt(1 / 10) * [-3-3i; -3-1i; -3+3i; -3+1i; -1-3i; -1-1i; -1+3i; -1+1i; 3-3i; 3-1i; 3+3i; 3+1i; 1-3i; 1-1i; 1+3i; 1+1i];
    % Normalized constellation points for 16-QAM having average symbol power 1 
end

c_hat = zeros(length(d_hat)*K, 1);
j=1;

for i = 1 : length(d_hat)
    
    distance = abs(d_hat(i) - constellation_points);    % Calculating distances from symbol to constellation points
    [~, constellation_index] = min(distance);  
    binary_value= de2bi(constellation_index - 1, K, 'left-msb')'; 
    c_hat(j : j+3) = binary_value;
    j=j+4;
    
end

if switch_graph == 1
    
    D = scatterplot(d_hat, 1, 0, 'go');
    hold on
    scatterplot(constellation_points, 1, 0, 'k*', D)
    title('Figure of the received symbols')
    grid on
    
end

end