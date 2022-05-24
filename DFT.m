function DFT(user, exp, xn, label, nomes_atividades)

    N = length(xn);
    fs = 50;
    
    for i = 1:length(nomes_atividades)
        % Guardar atividade que se esta a trabalhar
        l = label(label(:,1) == i, 2:end);

    % Plot para cada DFT
        figure;
        t = tiledlayout(3,1);
        t.Padding = 'compact';
        t.TileSpacing = 'compact';

        title(t, "Experiencia " + exp + " do user " + user + " ||" + nomes_atividades(i)+ "||");
        xlabel(t, "Frequencia (Hz)"); 
        ylabel(t, "Magnitude");
    
        ax1 = nexttile(1);
        title("|DFT| ACC_X")
        hold on;

        ax2 = nexttile(2);
        title("|DFT| ACC_Y")
        hold on;
    
        ax3 = nexttile(3);
        title("|DFT| ACC_Z")
        hold on;
    
        linkaxes([ax1, ax2, ax3],'xy');
        yticklabels(ax2,{});
        yticklabels(ax3,{});
    
        for j = 1:size(l,1)
            inicio = l(j,1);
            fim = l(j, 2);

            x = xn(inicio:fim, 1);
            y = xn(inicio:fim, 2);
            z = xn(inicio:fim, 3);
    
            % DFT
            X = abs(fftshift(fft(x)));
            Y = abs(fftshift(fft(y)));
            Z = abs(fftshift(fft(z)));
    
            N = fim - inicio +1;
            if(mod(N,2)==0)
                ff = -fs/2: fs/N :fs/2-fs/N;
            else
                ff = -fs/2+fs/(2*N): fs/N :fs/2-fs/(2*N);
            end
            xlim(ax1, [ff(1) ff(end)]);
    
            plot(ax1, ff, X);
            plot(ax2, ff, Y);
            plot(ax3, ff, Z);

            m = max([max(X) max(Y) max(Z)]);
            ylim(ax1,[0 m+1]);

        end
    end

end