function visualizeRawVsFilteredRSS(dist, data)
    figure;
    for i = 1:length(dist)
        subplot(5,1,i)
        elapsed = data.elapsed(data.dist==dist(i));
        rss = data.rss(data.dist==dist(i));
        mRSS = data.mRSS10(data.dist==dist(i));
        
        if(length(rss)>100)
            endpoint = 100;
        else
            endpoint = length(rss);
        end
        plot(elapsed(1:endpoint), rss(1:endpoint) , '--xk', 'MarkerSize', 10, 'DisplayName', 'Raw RSS')
        hold
        plot(elapsed(1:endpoint), mRSS(1:endpoint), '-r', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Filtered RSS')
        hold
        
        %xlim([min(elapsed), max(elapsed(1:endpoint))])
        title(strcat("Distance: ", string(dist(i)), "$cm$"), 'Interpreter', 'latex');
        xlabel('Time ($s$)', 'Interpreter', 'latex');
        ylabel('RSS ($dBm$)', 'Interpreter', 'latex');
        lg = legend('show');
        lg.Interpreter = 'latex'; 
        lg.FontSize = 15; lg.FontName = "Times New Roman"; 
        ax = gca; ax.FontSize = 14; ax.FontName = "Times New Roman"; 
    end
end