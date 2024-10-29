function [d_hat] = filter_rx(s_hat, dsf_filter, switch_graph)

t = linspace(-3.2, 3.2, 25);
rx_filter = sinc(t);    % Low-pass filter


rx_filter_output = conv(s_hat, rx_filter);

d_hat_temp= rx_filter_output (length(rx_filter):1:end-length(rx_filter)-1);


d_hat_filtered = downsample(d_hat_temp,dsf_filter); % Downsampling by downsampling factor


d_hat = d_hat_filtered / sqrt(mean(abs(d_hat_filtered).^2));  % Normalizing filter output signal

if switch_graph == 1
    
    eyediagram(d_hat, 2)
    
    figure('Name', 'Receiver Filter Output')
    
    subplot(3,1,1)
    plot(real(d_hat_filtered))
    grid on
    title('Receiver Filter Output without normalization')
    xlabel('Time')
    ylabel('Amplitude')
    legend ('Real')
    
    subplot(3,1,2)
    plot(real(d_hat),'b')
    grid on
    title('Receiver Filter output after normalization')
    xlabel('Time')
    ylabel('Amplitude')
    legend ('Real')
    
    
    subplot(3,1,3)
    plot(imag(d_hat),'g')
    grid on
    xlabel('Time')
    ylabel('Amplitude')
    legend ('Imaginary')
    
end

end