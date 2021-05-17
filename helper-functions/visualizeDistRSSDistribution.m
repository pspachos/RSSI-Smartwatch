function visualizeDistRSSDistribution(dist, dataNature, dataTable, minRss, maxRss, meanRss, modeRss, medRss, plotTitle)
    figure;
    subplot(5, 5, [1:4, 6:9, 11:14])
    plot(dataTable.dist, dataTable.rss, 'xk', 'DisplayName', strcat(dataNature, ' RSS Measurement'));
    hold;
    plot(dist, minRss, '-r', 'LineWidth', 2, 'DisplayName', 'Min');
    plot(dist, maxRss, '-r', 'LineWidth', 2, 'DisplayName', 'Max');
    plot(dist, meanRss, '--b', 'LineWidth', 2, 'DisplayName', 'Mean');
    plot(dist, modeRss, '--r', 'LineWidth', 2, 'DisplayName', 'Mode');
    plot(dist, medRss, '--g', 'LineWidth', 2, 'DisplayName', 'Median');
    xlabel("Distance ($cm$)", 'Interpreter', 'latex');
    ylabel("RSS ($dBm$)", 'Interpreter', 'latex');
    title(plotTitle);
    lg = legend('show');
    lg.Interpreter = 'latex'; 
    lg.FontSize = 15; lg.FontName = "Times New Roman"; 
    ax = gca; ax.FontSize = 14; ax.FontName = "Times New Roman"; 


    for i = 1:length(dist)
        if i == 1
            subplot(5, 5, 5)
        elseif i ==2
            subplot(5,5,10)
        elseif i ==3
            subplot(5,5,15)
        else
            subplot(5,5,i+12)
        end
        tempData = dataTable.rss(dataTable.dist == dist(i)); 
        histogram(tempData);
        title([strcat("Distance: ", string(dist(i)), "$cm$"); ...
            strcat("Mean: ", string(mean(tempData)), " Var: ", string(var(tempData)))], 'Interpreter', 'latex');
        ax = gca; ax.FontSize = 11; ax.FontName = "Times New Roman"; 
    end

end