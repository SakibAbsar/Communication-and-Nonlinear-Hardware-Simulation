function [y] = simulate_channel(x, SNRs_dB, switch_graph)

n = sqrt(1 / 2) * (1 * randn(length(x), 1) + 1j * randn(length(x), 1));    % White Gaussian Noise with mean 0 and variance 1
sigma = sqrt(mean(abs(x).^2) / 10^(SNRs_dB / 10));    % Noise statndard deviation
y = x + sigma * n;  % Noisy signal over the AWGN channel

if switch_graph == 1
    
    figure('name', 'Transmitted Signal and Received Signal')
    subplot(2, 1, 1)
    plot(abs(x))
    title('Transmitted Signal')
    xlabel('Time')
    ylabel('Magnitude')
    subplot(2, 1, 2)
    plot(abs(y))
    title('Received Signal')
    xlabel('Time')
    ylabel('Magnitude')
    
end

end
