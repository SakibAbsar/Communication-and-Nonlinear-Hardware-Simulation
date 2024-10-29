function [b] = generate_digital_signal(n_bits)

b = rand(n_bits, 1) > 0.5;  % Generate bit stream (0s and 1s with equal probabiblity, mean 0.5)

end
