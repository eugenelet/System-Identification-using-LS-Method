% Simulation for MSE vs Monte Carlo Iteration

for i=5:5:1000
	SNR_awgn(i/5) = sys_id_LMS(10, i, 10, 1);
end

x = 5:5:1000;
plot(x, SNR_awgn)
title('MSE vs. Monte Carlo Iteration')
xlabel('Monte Carlo Iteration')
ylabel('MSE')

