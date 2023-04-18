
% 画出绿色草地
patch([0 1100 1100 0], [0 0 700 700], [0 0.5 0]);

% 画出白色边线
patch([100 1000 1000 100], [50 50 650 650], [1 1 1]);

%左半场
patch([105 547 547 105], [55 55 645 645], [0 0.5 0]);
%Penatly area
patch([105 305 305 105], [100 100 600 600], [1 1 1]);
patch([105 302 302 105], [103 103 597 597], [0 0.5 0]);
%goal area
patch([105 205 205 105], [200 200 500 500], [1 1 1]);
patch([105 202 202 105], [203 203 497 497], [0 0.5 0]);
%gate area
patch([40 100 100 40], [220 220 480 480], [1 1 1]);
patch([43 100 100 43], [223 223 477 477], [0 0.5 0]);

%右半场 
patch([553 995 995 553], [55 55 645 645], [0 0.5 0]);
%Penatly area
patch([795 995 995 795], [100 100 600 600], [1 1 1]);
patch([798 995 995 798], [103 103 597 597], [0 0.5 0]);
%goal area
patch([895 995 995 895], [200 200 500 500], [1 1 1]);
patch([898 995 995 898], [203 203 497 497], [0 0.5 0]);
%gate area
patch([1000 1060 1060 1000], [220 220 480 480], [1 1 1]);
patch([1000 1057 1057 1000], [223 223 477 477], [0 0.5 0]);

viscircles([550 350],75,'Color','w');

% 设置坐标轴范围
axis([0 1100 0 700]);

