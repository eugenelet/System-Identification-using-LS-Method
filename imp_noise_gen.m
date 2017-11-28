function [Imp_noise] = imp_noise_gen(y,N,SNR);
%
% [Imp_noise] = imp_noise_gen(y,N,SNR);
%
% [Imp_noise] = imp_noise_gen(y,N,SNR) generates impulsive noise which
% satisfies the SNR argument in dB.  N is the total number of samples in
% the output Imp_noise.  y is a Nx1 signal vector that is used to measure
% the SNR.
%
% The function either changes the bias and/or sparseness of the output
% vector in meet the SNR requirement

% generating impulse noise
max_imp_noise_percentage = 0.5;
P = max_imp_noise_percentage;
impnoise_bias = 40;
random_idx=randperm(N);     %Generate random index (index from 1 to N);
Imp_noise = zeros(N,1);
% Computing impulse noise based on SNR by either changing the pdf
% bias or decreasing the number of nonzero samples
while ( ~( (10*log10(var(y)/var(Imp_noise)) <= SNR+0.5) & (10*log10(var(y)/var(Imp_noise)) >= SNR-0.5) ) ) %& P > eps )
    Imp_noise = zeros(N,1);
    for i=1:round(P*N)    % P=0.3 means 30% of samples will be impulsive noise
        %heavy tail noise, which pdf is 1/2*(U[impnoise_bias,impnoise_bias+1]+U[-impnoise_bias,-impnoise_bias-1]),are
        %assigned to random places of Imp_noise
        Imp_noise(random_idx(i)) = (impnoise_bias+rand(1) + j*(impnoise_bias+rand(1))) * (-1)^(randi([0,1]));
    end
    if ( ( P <= max_imp_noise_percentage) & (10*log10(var(y)/var(Imp_noise)) > SNR+0.5) & P > .1 )
        % noise power too low, increaes bias
        impnoise_bias = impnoise_bias + 1;
    elseif ( ( P <= max_imp_noise_percentage) & (10*log10(var(y)/var(Imp_noise)) < SNR-0.5) & P > .1 )
        % noise power too high, add more sparsity
        P = P - 0.01;
    elseif (P <= .1)
        % have reduced noise power where the nonzero elements of the 
        % impulsive noise is only 10% or less, but still cannot meet SNR
        % requirement.  Hence, reset sparisty to 50% and reduced bias
        P = max_imp_noise_percentage;
        if (SNR >= 12)
            impnoise_bias = impnoise_bias - 1/(sqrt(SNR) * 20);
        else
            impnoise_bias = impnoise_bias - 1;
        end
    else
        break;
    end
end

% Below 3 lines are not good implementation of satisfying
% the SNR requirement because it keeps decreasing the bias
% value, i.e. decreaseing the amplitude of the impulse
% noise
%imp_noise_pwr = Imp_noise'*Imp_noise/total_samp;
%Imp_noise = Imp_noise/sqrt(imp_noise_pwr);
%Imp_noise = sqrt(noisepwr)*Imp_noise;