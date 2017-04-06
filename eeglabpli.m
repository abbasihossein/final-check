clear all
clc
Fs = 1000;
data = importdata('data_block001.mat');
signal = data.F(1:308,:);
chan_num = size(signal,1);
PLI_sum = zeros(chan_num,chan_num);
L = 4*Fs;                          %Length of  window is 4s or 4000 samples 

W = hamming(L); %for Windowning
for trial_num = 1:round(size(signal,2)/(2*Fs))-1 ; 
Signal = F(1:chan_num,Fs*2*(trial_num - 1)+1:2*(trial_num +1)*Fs);
%^^ breaking data to epoch with lenght 4000 samples and 2000 samples
%overlap

for j = 1:chan_num;
     SignalWIN = W*Signal(chan_num,:);
Phase(j,:) = angle(hilbert(SignalWIN(j,:)));%Compute phase for all data
end

for i = 1:chan_num;
    for m = 1:chan_num;
        PLI(i,m) = abs(mean(sin(sign(Phase(i,:)-Phase(m,:)))));
    end
end
PLI_sum = PLI + PLI_sum;

end

PLI_final = PLI_sum/trial_num;

PLI_Over_Cortex = sum(PLI_final,1)/size(PLI_final,1);

 
figure;
imagesc(PLI_final)
colorbar
title('PLI(with Hamming window)')
xlabel('Channels')
ylabel('channels')
final check
 
