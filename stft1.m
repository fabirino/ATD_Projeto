function stft1(data,N,f_frame,Nframe)
    fs = 50;
    b = blackman(Nframe); %janela de blackman
    
    espetro = [];
    n = 0;
    ti_frame = [];
   
    for i = 1:Nframe:N-Nframe
        x_frame = data(i:i+Nframe-1).*b;
        x_frame = abs(fftshift(fft(x_frame)));
        ti_frame = [ti_frame n*Nframe/fs];
        n = n + 1;
        espetro = [espetro x_frame];
    end
    figure()
    imagesc('XData',ti_frame,'YData',f_frame,'CData',mag2db(espetro));
    colorbar;
    xlabel('t [s]');
    ylabel('f [Hz]');
    title('stft');
end