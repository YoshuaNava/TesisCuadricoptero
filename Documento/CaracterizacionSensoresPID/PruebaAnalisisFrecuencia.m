tF = 10;
Fs = 200;
t = 0:(1/Fs):tF;
numeroDatos = size(t,2);

armonico5 = sin(2*pi*5*t);
armonico20 = sin(2*pi*20*t);
armonico50 = sin(2*pi*50*t);
senal = armonico5 + armonico20 + armonico50;
plot(t,senal);

NFFT_senal = 2^nextpow2(numeroDatos);
f = Fs/2*linspace(0,1,NFFT_senal/2+1);
fft_senal = fft(senal, NFFT_senal)/numeroDatos;
plot(f,2*abs(fft_senal(1:NFFT_senal/2+1))) 
