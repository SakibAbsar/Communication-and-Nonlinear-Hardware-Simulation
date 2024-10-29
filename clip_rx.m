function [s_hat] = clip_rx(y, rxthresh, switch_graph)

magnitude_of_y = abs(y);
angle_of_y = angle(y);

for j=1:length(magnitude_of_y)
    
    if magnitude_of_y(j)>=rxthresh
        magnitude_of_y(j)=rxthresh; %values which are equal or greater than rxthresh is set to rxthresh
    else
        magnitude_of_y(j)= magnitude_of_y(j); %values less than rxthresh remains unchanged
    end
end

[a, b] = pol2cart(angle_of_y, magnitude_of_y); 
s_hat = a + b * 1i; % Polar to cartesian transformation


if switch_graph == 1
    
    figure('name','Figure of (non-)clipped signal (Rx Hardware)')
    subplot(2,1,1)
    plot(abs(y),'r')
    title('Rx Hardware input')
    xlabel('Time')
    ylabel('Magnitude')
    grid on
    
    subplot(2,1,2)
    plot(abs(s_hat),'b')
    grid on
    title('Rx Hardware output')
    xlabel('Time')
    ylabel('Magnitude')
    
end

end