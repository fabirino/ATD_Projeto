function [] = DFT(user, exp, xn, label, nomes_atividades)
    fs = 50;
    disp("User: " + user + " Experiencia: " + exp );
    
    for i = 1:length(nomes_atividades)
        % Guardar atividade que se esta a trabalhar
        l = label(label(:,1) == i, 2:end);

        freqsX = [];
        freqsY = [];
        freqsZ = [];

        % Plot para cada DFT
%          figure;
%          t = tiledlayout(3,1);
%          t.Padding = 'compact';
%          t.TileSpacing = 'compact';
%  
%          title(t, "Experiencia " + exp + " do user " + user + " ||" + nomes_atividades(i)+ "||");
%          xlabel(t, "Frequencia (Hz)"); 
%          ylabel(t, "Magnitude");
%      
%          ax1 = nexttile(1);
%          title("|DFT| ACC_X")
%          hold on;
%  
%          ax2 = nexttile(2);
%          title("|DFT| ACC_Y")
%          hold on;
%      
%          ax3 = nexttile(3);
%          title("|DFT| ACC_Z")
%          hold on;
%      
%          linkaxes([ax1, ax2, ax3],'xy');
%          yticklabels(ax2,{});
%          yticklabels(ax3,{});
      
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
%              xlim(ax1, [ff(1) ff(end)]);
% 
%              m = max([max(X) max(Y) max(Z)]);
%              ylim(ax1,[0 m+1]);
    
%              plot(ax1, ff, X);
%              plot(ax2, ff, Y);
%              plot(ax3, ff, Z);

            % Frequencias relevantes
            
            max_x = max(X(ff ~= 0));
            f_relev = ff(X == max_x);
            f_relev = f_relev(f_relev>0);
            freqsX = [freqsX f_relev];
            
            max_y = max(Y(ff ~= 0));
            f_relev = ff(Y == max_y);
            f_relev = f_relev(f_relev>0);
            freqsY = [freqsY f_relev];
            
            max_z = max(Z(ff ~= 0));
            f_relev = ff(Z == max_z);
            f_relev = f_relev(f_relev>0);
            freqsZ = [freqsZ f_relev];


        end
        fprintf(nomes_atividades(i));

        fprintf("\nACC_X: ")
        for k = 1:length(freqsX)
            fprintf("%.4f  ", freqsX(k));
        end

        fprintf("\nACC_Y: ")
        for k = 1:length(freqsY)
            fprintf("%.4f  ", freqsY(k));
        end

        fprintf("\nACC_Z: ")
        for k = 1:length(freqsZ)
            fprintf("%.4f  ", freqsZ(k));
        end
        fprintf("\n\n");


        figure()
        spectrogram(xn(inicio:fim, 3));
        spectrogram(xn(inicio:fim, 3),'yaxis');
        title("Activity: " + nomes_atividades(i));

    end
end