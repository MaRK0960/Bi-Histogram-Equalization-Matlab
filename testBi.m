[filename,pathname] = uigetfile({'*.jpg';'*.pgm'},'Choose the image');
I = imread(fullfile(pathname,filename));
 
HM = round(mean2(I));
ILE = find(I>=HM);
IHE = find(I<HM);

IL = I;
IL(ILE)=0;
IH = I;
IH(IHE)=0;

[~, lowMap] = histeq(IL,HM);
[~, highMap] = histeq(IH,256-HM);
lookupTable = uint8([HM*lowMap(1:HM), 256*highMap(HM+1:end)]);
HEI = intlut(I, lookupTable);
 
MI= mean2(I);
MEI = mean2(HEI);
SI= std2(I);
SIE=std2(HEI);

figure('NumberTitle', 'off', 'Name','Original Image')
subplot(1,2,1)
imshow(I)
title('Original Image','fontsize',22)
subplot(1,2,2)
imhist(I)
text(150,4000,{'Mean =', num2str(MI),'Standard Diviation =',num2str(SI)},'Color','black','FontSize',13)
figure('NumberTitle', 'off', 'Name','Bi Histogrtam Equalization Image')
subplot(1,2,1)
imshow(HEI)
title('Bi Histogram Equilization','fontsize',22)
subplot(1,2,2)
imhist(HEI)
text(130,5000,{'Mean =', num2str(MEI),'Standard Diviation =',num2str(SIE)},'Color','black','FontSize',13)
 
