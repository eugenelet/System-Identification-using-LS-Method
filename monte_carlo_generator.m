function [mont_carlo] = monte_carlo_generator(gen_size, sample_size)

mont_carlo = zeros(gen_size, sample_size);
for i = 1:gen_size
	mont_carlo(i,:) = (randn(sample_size, 1) + j * randn(sample_size, 1) ) / sqrt(2);
end
