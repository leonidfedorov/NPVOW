function [standarderror] = plotLFAPres2(dname)

dname = 'C:\Users\LocalAdminLeo\Documents\MATLAB\NPVOW\LFAP\exp2\results\BG0.8';

listing = dir(dname);
listing(1:2) = []; %cut off references to parent folders, only keep the filenames
numfiles = numel(listing);


conditionnames = [{'1: body only'}, {'2: thighs'}, {'3: forearms'}, ...
    {'4: legs'}, {'5: thighs and legs'}, {'6: forearms and thighs'}, ...
    {'7: forearms and legs'}, {'8: everything'}, {'9: none'}];
colorlist = [240, 163, 10;...
    130, 90, 44;...
    162, 0, 37;...
    0, 80, 239;...
    27, 161, 226;...
    0, 138, 0;...
    96, 169, 23;...
    106, 0, 255;...
    164, 196, 0;...
    216, 0, 115;...
    118, 96, 138;...
    109, 135, 100;...
    250, 104, 0;...
    244, 114, 208;...
    229, 20, 0;...
    100, 118, 135;...
    135, 121, 78;...
    0, 171, 169;...
    170, 0, 255;...
    227, 200, 0]/256; 
shiftlist = [0:0.1964/15:0.1963]/3;


% towaAll = inf(17,17,numfiles);
% awayAll = inf(17,17,numfiles);
% towaAllMean = inf(17,numfiles);
% towaAllStd = inf(17,numfiles);
% awayAllMean = inf(17,numfiles);
% awayAllStd = inf(17,numfiles); 


meansPerSubjectAB = inf(numfiles,numel(conditionnames));
meansPerSubjectAA = inf(numfiles,numel(conditionnames));
meansPerSubjectTB = inf(numfiles,numel(conditionnames));
meansPerSubjectTA = inf(numfiles,numel(conditionnames));

%towaAxes = axes('position',[800, 100, 300, 200]);
jointFigure = figure(1);
%awayFigure = figure(2);


for n = 1:numfiles,
    color =colorlist(n,:);
    shift = shiftlist(n);
    %scale = 10;

    [aa,ab,ta,tb] = loadsubstat(listing(n).name);
    
    awaymeansAcc = cat(2,1-ab,1-aa);
    towameansAcc = cat(2,tb,ta);
    
    meansPerSubjectAB(n,:) = 1-ab;
    meansPerSubjectAA(n,:) = 1-aa;
    meansPerSubjectTB(n,:) = tb;
    meansPerSubjectTA(n,:) = ta;
    
    %towaAll(:,:,n) = towa;
    %towaAllMean(:,n) = mean(towa(:,3:17),2);
    %towaAllStd(:,n) = std(towa(:,3:17),[],2)/sqrt(15);
    
    set(0, 'currentfigure', jointFigure);  %# for figures
%    plot(towaAll(:,1,n)+shift,towaAllMean(:,n),'LineStyle','-.','Color',color,'LineWidth',3.0); hold on;
%    set(gca,'XTickLabel',[0:11.25:180]);
    for condind = 1:9,
        subplot(2,9,condind)
        title(conditionnames(condind));
        plot([0,1],awaymeansAcc(condind,:),'Color',color,'LineWidth',1.0,'LineStyle','--','Marker','d'); hold on;
        set(gca,'YLim',[-0.1, 1.1],'XLim',[-0.1,1.1]);% axis tight;
        subplot(2,9,condind+9)
        title(conditionnames(condind));
        plot([0,1],towameansAcc(condind,:),'Color',color,'LineWidth',1.0,'LineStyle','--','Marker','d'); hold on;     
        set(gca,'YLim',[-0.1, 1.1],'XLim',[-0.1,1.1]); %axis tight;
        %set(gca,'XTickLabel',[0,1]);
    end

    %shadedErrorBar(towa(:,1), towaAllMean(:,n), towaAllStd(:,n)/sqrt(15),{'LineStyle','-','LineWidth',3.0,'Color',color},1);hold on;
    %errorbar(towaAll(:,1,n)+shift,towaAllMean(:,n),towaAllStd(:,n),'LineStyle','-','Color',color,'LineWidth',3.0); hold on;
    
    
%     awayAll(:,:,n) = away;
%     awayAllMean(:,n) = 1-mean(flipud(away(:,3:17)),2);
%     awayAllStd(:,n) = 1-std(flipud(away(:,3:17)),[],2)/sqrt(15);
% 
%     
%     set(0, 'currentfigure', awayFigure);  %# for figures
%     plot(towaAll(:,1,n)+shift,awayAllMean(:,n),'LineStyle','-.','Color',color,'LineWidth',3.0); hold on;
%     set(gca,'XTickLabel',[0:11.25:180]);
%     
    
%     if n==3
%         display(n)
%     end
%     if n==9,
%         display(n)
%     end
end

for condind = 1:9,
    set(0, 'currentfigure', jointFigure); 
    subplot(2,9,condind)
    title(conditionnames(condind));
    plot([0,1],[mean(meansPerSubjectAB(:,condind)),mean(meansPerSubjectAA(:,condind))],'Color','black','LineWidth',2.0,'LineStyle','-','Marker','.'); hold on;
    set(gca,'YLim',[-0.1, 1.1],'XLim',[-0.1,1.1]);
    subplot(2,9,condind+9)
    title(conditionnames(condind));
    plot([0,1],[mean(meansPerSubjectTB(:,condind)),mean(meansPerSubjectTA(:,condind))],'Color','black','LineWidth',2.0,'LineStyle','-','Marker','.'); hold on;
    set(gca,'YLim',[-0.1, 1.1],'XLim',[-0.1,1.1]);
end

extSPSSstyleMeans = [ ];%inf(numfiles,4*9);
for ind = 1:9,
    meansPerCondition = [meansPerSubjectAB(:,ind) meansPerSubjectAA(:,ind) meansPerSubjectTB(:,ind) meansPerSubjectTA(:,ind)];
    csvwrite(strcat(num2str(ind),'.csv'),meansPerCondition);
    extSPSSstyleMeans = cat(2,extSPSSstyleMeans, meansPerCondition);
end

csvwrite('LFAPexp2.csv', extSPSSstyleMeans)

% % % % towaPulledMean = mean(towaAllMean,2);
% % % % towaPulledStd = std(towaAllMean,[],2);
% % % % set(0, 'currentfigure', towaFigure);
% % % % shadedErrorBar(towa(:,1),towaPulledMean,towaPulledStd/sqrt(13),{'LineStyle','-','LineWidth',4.0,'Color',[0 0 0]},1)
% % % % xlim([-pi/4 5*pi/4]);
% % % % ylim([-0.2 1.2]);
% % % % grid on;
% % % % title({'walking towards', 'increase in X axis means light source moving up', ...
% % % %      'increase in Y axis means being more correct'});
% % % % 
% % % % awayPulledMean = mean(awayAllMean,2);
% % % % awayPulledStd = std(awayAllMean,[],2);
% % % % set(0, 'currentfigure', awayFigure);
% % % % shadedErrorBar(towa(:,1),awayPulledMean,awayPulledStd/sqrt(13),{'LineStyle','-','LineWidth',4.0,'Color',[0 0 0]},1)
% % % % xlim([-pi/4 5*pi/4]);
% % % % ylim([-0.2 1.2]);
% % % % grid on;
% % % % title({'walking away', 'increase in X axis means light source moving up', ...
% % % %      'increase in Y axis means being more correct'});
% % % % 
% % % % 
% % % % tttable_towa = tril(ones(17,17),0);
% % % % tttable_away = tril(ones(17,17),0);
% % % % temp_towa = towaAllMean'
% % % % temp_away = awayAllMean'
% % % % 
% % % % 
% % % % [p_towa,table_towa]=anova_rm(temp_towa)
% % % % [p_away,table_away]=anova_rm(temp_away)
% % % % 
% % % % 
% % % % for rowInd = 1:17,
% % % %     for colInd = (rowInd+1):17,
% % % %         %[rowInd,colInd]
% % % %         [h,p,ci,stats] = ttest(temp_towa(:,rowInd),temp_towa(:,colInd),'dim',1);
% % % %         tttable_towa(rowInd,colInd) = stats.tstat;
% % % %         [h,p,ci,stats] = ttest(temp_away(:,rowInd),temp_away(:,colInd),'dim',1);
% % % %         tttable_away(rowInd,colInd) = stats.tstat;
% % % %     end
% % % % end
display(1);
% for n = 3:17,
%     [p_towa, table_towa, stats_towa] = anova1(squeeze(towaAll(:,n,:)));
%     [c_towa,m_towa,h_towa,gnames_towa] = multcompare(stats_towa)%,'ctype','scheffe');
% end
 
%FIXME: the line below can be very confusing, hence the explanation:
%anova2 function takes
% towaPerm = reshape(permute(towaAll(:,3:17,:),[2 3 1]),12*15,[])
% awayPerm = reshape(permute(awayAll(:,3:17,:),[2 3 1]),12*15,[])
% 
% [p_towa,table_towa,stats_towa] = anova2(towaPerm,15)
% [p_away,table_away,stats_away] = anova2(awayPerm,15)
% 
% c_towa = multcompare(stats_towa,'ctype','scheffe')
% c_away = multcompare(stats_away,'ctype','scheffe')

return;