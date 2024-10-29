function [x] = clip_tx(s, txthresh, switch_graph)

magnitude_of_s= abs(s);
angle_of_s = angle(s);

for j=1:length(magnitude_of_s)
    
    if magnitude_of_s(j)>=txthresh
        magnitude_of_s(j)=txthresh; %values which are equal or greater than txthresh is set to txthresh
    else
        magnitude_of_s(j)= magnitude_of_s(j); %values less than txthresh remains unchanged
    end
end
  
[a, b] = pol2cart(angle_of_s,magnitude_of_s);
x = a + b * 1i; %  Transformation from polar to cartesian

if switch_graph == 1
    
    figure('name','Figure of (non-)clipped signal (Tx Hardware)')
    subplot(2, 1, 1)
    plot(abs(s),'r')
    title('Tx Hardware input')
    xlabel('Time')
    ylabel('Magnitude')
    grid on
    subplot(2, 1, 2)
    plot(abs(x),'b')
    grid on
    title('Tx Hardware output')
    xlabel('Time')
    ylabel('Magnitude')
    
end

end