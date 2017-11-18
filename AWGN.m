function awgn = AWGN(y,N,SNR)
% Implementation of additive gaussian white noise
	S = var(y);
	noise_amp = sqrt(S / (10^(SNR/10)));
	noise = randn(N, 1);
	awgn = noise * noise_amp;
end