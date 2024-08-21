function groupedbar(bardata,grpnames,grpvarnames,barerror)
%groupedbar plot bargraph with grouped data
%	Usage: groupedbar(bardata,grpnames,[grpvarnames],[barerror])
%
% Example: 
% mRNAlist=["Rpl1","Rpl2","Rpl3","Gsp1","Gsp2","Gsp3","NC"];
% len=numel(mRNAlist);
% bardata=zeros(len,2);
% barerror=zeros(len,2);
% for ii=1:len
%     sel1= (alldata.mpo == mRNAlist(ii) & alldata.sample=="total RNA");
%     sel2= (alldata.mpo == mRNAlist(ii) & alldata.sample=="purified RNA");
%     bardata(ii,1)=mean(alldata.Intensity(sel1)-alldata.Donut(sel1));
%     barerror(ii,1)=std(alldata.Intensity(sel1)-alldata.Donut(sel1));
%     bardata(ii,2)=mean(alldata.Intensity(sel2)-alldata.Donut(sel2));
%     barerror(ii,2)=std(alldata.Intensity(sel2)-alldata.Donut(sel2));
% end %for
% groupedbar(bardata,mRNAlist,{"total RNA","purified RNA"},barerror)
% xlabel("Morpholino", 'FontSize',16);
% ylabel("Intensity(donut background corrected)", 'FontSize',16);
% title("mRNA Detection", 'FontSize',20)

bar(bardata)
if nargin >3
    hold on
    ngroups = size(bardata, 1);
    nbars = size(bardata, 2);
    % Calculating the width for each bar group
    groupwidth = min(0.8, nbars/(nbars + 1.5));
    for i = 1:nbars
        x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
        errorbar(x, bardata(:,i),  zeros(ngroups,1),barerror(:,i),'.k');
    end
    hold off
end %if
if nargin >2
    legend(grpvarnames)
    legend boxoff
end %if
if nargin >1
    set(gca,'xticklabel',grpnames)
end %if
end %function
