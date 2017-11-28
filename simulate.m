% simulation of MSE vs SNR for both AWGN and Impulse noise

for i=0:3:18
	display(i)
	SNR_awgn(i/3 + 1) = sys_id_LMS(10, 1000, i, 1);
	SNR_imp(i/3 + 1) = sys_id_LMS(10, 1000, i, 0);
end

x = 0:3:18;
plot(x, SNR_awgn, 'b.', x, SNR_imp, 'ro')
legend('AWGN', 'Impulse Noise')
title('MSE vs. SNR')
xlabel('SNR')
ylabel('MSE')

