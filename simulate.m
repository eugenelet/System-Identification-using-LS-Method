

SNR_awgn = zeros(10);
SNR_imp = zeros(10);
for i=0:3:30
	SNR_awgn(i/3 + 1) = sys_id_LMS(10, 1000, i, 1);
	SNR_imp(i/3 + 1) = sys_id_LMS(10, 1000, i, 0);
end

x = 0:3:30
plot(x, SNR_awgn, 'b.', x, SNR_imp, 'ro')
legend('AWGN', 'Impulse Noise')
title('MSE vs. SNR')
xlabel('SNR')
ylabel('MSE')

%
%plot(SNR_awgn)
% clf
% iter_awgn = zeros(100);
% for i=1:300
	% iter_awgn(i) = sys_id_LMS(10, i, 30, 1);
% end
% plot(iter_awgn)
