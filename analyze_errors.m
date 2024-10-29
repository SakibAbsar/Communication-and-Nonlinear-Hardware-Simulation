function [BER] = analyze_errors(b, b_hat, c, c_hat, switch_graph)

error_coded = (b ~= b_hat);  % Erroneous bits
error_uncoded = (c ~= c_hat);

BER_coded = sum(error_coded) / length(b);   % BER calculation for coded
BER_uncoded = sum(error_uncoded) / length(c);   % BER calculation for uncoded

BER = [BER_coded BER_uncoded];

if switch_graph == 1
    
    figure('name','Representation of Erroneous Positions')
    subplot(3,1,1)
    stem(b,'g')
    title('Original Signal')
    grid on
    subplot(3,1,2)
    stem(b_hat,'r')
    title('Estimated Signal')
    subplot(3,1,3)
    stem(error_coded,'c','LineWidth',0.5)
    title('Error')
    
end

end