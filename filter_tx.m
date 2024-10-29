function [s] = filter_tx(d, usf_filter, switch_graph)

d_upsampled = upsample(d,usf_filter); % Upsampling by upsampling factor

t = linspace(-3.2, 3.2,25);
tx_filter = sinc(t); % designing low-pass filter

tx_filter_output = conv(d_upsampled, tx_filter);

s = tx_filter_output / sqrt(max(abs(tx_filter_output).^2)) ; % Normalizing filter output signal

if switch_graph == 1
    
    figure('Name', 'Transmitter Filter Output')
    
    subplot(3,1,1)
    plot(real(tx_filter_output))
    grid on
    title('Transmitter Filter Output without normalization')
    xlabel('Time')
    ylabel('Amplitude')
    legend ('Real')
   
    
    subplot(3,1,2)
    plot(real(s),'b')
    grid on
    title('Transmitter Filter Output after normalization')
    xlabel('Time')
    ylabel('Amplitude')
    legend ('Real')
    
    subplot(3,1,3)
    plot(imag(s),'g')
    grid on
    xlabel('Time')
    ylabel('Amplitude')
    legend ('Imaginary')
    
end

end