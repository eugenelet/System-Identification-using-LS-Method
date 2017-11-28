function [mse] = sys_id_LMS(coef, mont_carlo_iter, SNR, noise_type)

% coef: Filter Coefficients
% mont_carlo_iter: Monte Carlo Iteration
% SNR: Signal to Noise Ratio
% noise_type: 0=impulse 1=awgn


x = monte_carlo_generator(mont_carlo_iter, 100); % Signal generation using monte carlo simulation

% Generate Additive noise (AWGN or Impulse)
W = zeros(mont_carlo_iter, 100);
for i=1:mont_carlo_iter
	display(i)
	if noise_type
		W(i,:) = AWGN(x(i,:), 100, SNR);
	else
		W(i,:) = imp_noise_gen(x(i,:), 100, SNR);
	end
end

% Generate toeplitz matrix for matrix multiplication of LMS
X = zeros(mont_carlo_iter, 100, coef + 1);
for i=1:mont_carlo_iter
	X(i,:,:) = toeplitz(x(i,:), [x(i,1) zeros(1, coef + 1 - 1)]);
end

% LMS Estimation + MSE computation
mse = 0;
y = zeros(mont_carlo_iter, 100);
for i=1:mont_carlo_iter
	h_d = 10 * ( randn(coef + 1, 1) + j * randn(coef + 1, 1)); % Unknown linear system (different for every simulation)
	X_ = reshape(X(i,:,:), size(X,2), size(X,3));
	W_ = reshape(W(i,:), size(W,2), 1);
	y(i,:) = X_ * h_d + W_; %  Output of uknown system with additive noise
	y_ = reshape(y(i,:), size(y,2), 1);
	h = inv(X_' * X_) * X_' * y_;  % LS Predicted system
	mse = mse + sum(abs(h_d - h).^2);  % Accumulate MSE
end

mse = mse / (mont_carlo_iter * (coef + 1));  % Average over (monte carlo iteration * order of filter)



end