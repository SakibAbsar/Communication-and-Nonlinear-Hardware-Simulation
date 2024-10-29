function [c] = encode_hamming(b, parity_check_matrix, switch_cc_off)

generator_matrix = [eye(4),(parity_check_matrix(1:3,1:4))']; % Generator matrix(4*7)calculated by the parity check matrix (3*7)

if switch_cc_off == 1
    
    c = b; %block becomes transparent
    
else   %channel coding is in use
    c = zeros((length(b)*7)/4,1);% generating a column vector which has rows containing only 0's
    j=1;
    
    for i = 1 : 4 : length(b)
        b_temp=b(i:i+3); %Restructure the binary signal b
        codeword_temp =mod( b_temp' * generator_matrix,2); % codewords are generated from binary signals and generator matrix and normalized 
        c(j:j+6)= (codeword_temp(1:7))'; % generating a column vector from codewords 
        j=j+7;
        
    end
    
end

end