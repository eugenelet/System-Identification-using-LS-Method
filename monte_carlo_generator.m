function [mont_carlo] = monte_carlo_generator(gen_size, sample_size)

mont_carlo = zeros(1000, 100);
for i = 1:1000
mont_carlo(i,:) = (randn(sample_size, 1) + j * randn(sample_size, 1) ) / sqrt(2);
end
