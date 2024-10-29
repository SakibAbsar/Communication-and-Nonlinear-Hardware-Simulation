

%% This is main.m example for ICT Lab (CIT)
%
%  In this file, all main parameters are defined and all functions are
%  called. Please refer to this structure also given in the pdf-description
%  to write your code. However you might still modify the main loop, e.g. for
%  coded/uncoded simulation.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear; clc;

addpath('transmitter')
addpath('receiver')
addpath('channel')

%% define parameters % set and uncomment the parameters to use

switch_graph_run = 1;               % 0 for single SNR simulation, 1 for different SNRs simulation
switch_cc_off = 0;                  % 1 for no channel coding

n_bits = 100000;                    % no. of bits to transmit
parity_check_matrix = [1 0 1 1 1 0 0; 1 1 1 0 0 1 0; 0 1 1 1 0 0 1];    %  Parity check matrix
switch_mod = 1;                     % 0 for 16-QAM, 1 for 16-PSK
usf_filter = 8;                     % upsampling factor of tx filter
txthresh = 0.4;                       % threshold for tx clipping, 1 for no clipping, 0.7 for low clipping, 0.4 for severe clipping

rxthresh = 5;                       % threshold for rx clipping, 5 for no clipping, 0.7 for low clipping, 0.4 for severe clipping
dsf_filter = 8;                     % downsampling factor of rx filter

if switch_graph_run == 0
    
    SNRs_dB = 10;                   % single SNR simulation
    switch_graph = 1;

else
    
    SNRs_dB = 0 : 16;               % SNRs loop
    switch_graph = 0;

end

n_iter = 1;                         % No. of iteration

%% initialize vectors
% You can save the BER result in a vector corresponding to different SNRs

BER_uncoded = [];
BER_coded = [];

for ii = 1 : length(SNRs_dB)
    for jj = 1 : n_iter
        %% transmitter %%
        %generate bits
        b = generate_digital_signal(n_bits);
        
        %channel coding
        c = encode_hamming(b, parity_check_matrix, switch_cc_off);
        
        %modulation
        d = map2symbols(c, switch_mod, switch_graph);
        
        %tx filter
        s = filter_tx(d, usf_filter, switch_graph);
        
        %non-linear hardware
        x = clip_tx(s, txthresh, switch_graph);
        
        %% channel %%
        y = simulate_channel(x, SNRs_dB(ii), switch_graph);
        
        %% receiver %%
        %rx hardware
        s_hat = clip_rx(y, rxthresh, switch_graph);
        
        %rx filter
        d_hat = filter_rx(s_hat, dsf_filter, switch_graph);
        
        %demodulation
        c_hat = detect_symbols(d_hat, switch_mod, switch_graph);
        
        %channel decoding
        b_hat = decode_hamming(c_hat, parity_check_matrix, switch_cc_off, switch_graph);
        
        %digital sink, you can modify the interface (input and output variables)
        BER = analyze_errors(b, b_hat, c, c_hat, switch_graph);
      
    end
    
    BER_coded = [BER_coded BER(1)];    % BER with channel coding
    
    BER_uncoded = [BER_uncoded BER(2)];    % BER without channel coding
    
end

%% plot BER-SNR figure

if switch_graph_run == 1
    
    figure('name', 'BER vs SNR (dB)')
    semilogy(SNRs_dB, BER_coded, "go--", "LineWidth", 2)
    hold on
    semilogy(SNRs_dB, BER_uncoded, "r*-.", "LineWidth", 2)
    grid on
    xlabel("SNR (dB)")
    ylabel("BER")
    legend('Coded', 'Uncoded')
    
end








