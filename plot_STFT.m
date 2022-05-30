function plot_STFT(data,f_frame,Nframe)
Fs = 50;
Ts = 1/Fs;
N = numel(data);
t = N*Ts;
intervalo = 0.005;
Tframe = intervalo*t;

Toverlap = Tframe/2;

b = blackman(Nframe);

Noverlap = round(Toverlap*Fs);
espetro = [];
n = 0;
ti_frame = [];

for i = 1:Nframe:N-Nframe
    x_frame = data(i:i+Nframe-1).*b;
    x_frame = abs(fftshift(fft(x_frame)));
    ti_frame = [ti_frame n*Nframe/Fs];
    n = n + 1;
    espetro = [espetro, x_frame];
end

figure();
imagesc('XData',ti_frame,'YData',f_frame,'CData',mag2db(espetro));
colorbar;
xlabel('t [s]')
ylabel('f [Hz]')
title(['STFT | Window size: ',num2str(intervalo, '%.3fxt | OverLap 5%')])

end

