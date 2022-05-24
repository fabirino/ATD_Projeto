function plotgraph(exp, user, label, xn, Ts, nomes_atividades)
    N = length(xn);
    tt = 0:Ts:(N - 1)*Ts;
    tt = tt';
    figure;
    t = tiledlayout(3,1);
    t.Padding = 'compact';
    t.TileSpacing = 'compact';

    title(t, "Graficos obtidos para a experiencia " + exp + " do user " + user);
    xlabel(t, "Time (s)");

    % Eixo do X
    % Mudar para o proximo grafico do tiledLayout
    ax1 = nexttile(1);
    % Fazer o plot
    plot(tt, xn(:, 1), '-k');
    % Definir os limites do eixo do y
    ylim([min(xn(:,1))-0.25, max(xn(:,1))+0.25]);
    ylabel("ACC_X");
    hold on;

    % Eixo do Y
    ax2 = nexttile(2);
    plot(tt, xn(:, 2), '-k');
    ylim([min(xn(:,2))-0.25, max(xn(:,2))+0.25]);
    ylabel("ACC_Y");
    hold on;

    % Eixo do Z
    ax3 = nexttile(3);
    hold on;
    plot(tt, xn(:, 3), '-k');
    ylim([min(xn(:,3))-0.25, max(xn(:,3))+0.25]);
    ylabel("ACC_Z");
    hold on;

    linkaxes([ax1, ax2, ax3],'x');
    xticklabels(ax1,{});
    xticklabels(ax2,{});
    xlim(ax1, [0 (N-1)*Ts]);

    % Definir a altura onde vai ser colocado o texto da atividade
    height_lX = [max(xn(:,1)) min(xn(:,1))];
    height_lY = [max(xn(:,2)) min(xn(:,2))];
    height_lZ = [max(xn(:,3)) min(xn(:,3))];

    for i = 1:length(label)
        % indices do inicio e do fim
        inicio = label(i, 2);
        fim = label(i, 3);
    
        % Nome da atividade em questao
        str = nomes_atividades(label(i, 1));
        x_pos = tt(inicio);

        y_pos = height_lX(mod(i, 2) + 1);
        plot(ax1, tt(inicio:fim), xn(inicio:fim, 1));
        text(ax1, x_pos, y_pos, str, 'FontSize', 7);
        xline(ax1, x_pos, ':k');

        y_pos = height_lY(mod(i, 2) + 1);
        plot(ax2, tt(inicio:fim), xn(inicio:fim, 2));
        text(ax2, x_pos, y_pos, str, 'FontSize', 7);
        xline(ax2, x_pos, ':k');
    
        y_pos = height_lZ(mod(i, 2) + 1);
        plot(ax3, tt(inicio:fim), xn(inicio:fim, 3));
        text(ax3, x_pos, y_pos, str, 'FontSize', 7);
        xline(ax3, x_pos, ':k');
    end

end