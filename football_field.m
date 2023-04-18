
% FigureName = 'Robot Visualization'
% FigureTag = 'RobotVisualization'
% fig = figure('Name',FigureName,'tag',FigureTag)

% court = imread('football_field.png');
% imshow(court);
plotSoccerField;

hold on;
% A队

a1 = Player;
a1.Team = 1;
a1.headPosition =[150 350];
a1.setVelocity([15,20]);
plotSoccer(a1);

a2 = Player;
a2.Team = 1;
a2.headPosition = [250,350];
a2.setVelocity([0,0]);
plotSoccer(a2);

a3 = Player;
a3.Team = 1;
a3.headPosition = [420,200];
a3.setVelocity([0,0]);
plotSoccer(a3);

a4 = Player;
a4.Team = 1;
a4.headPosition = [420,500];
a4.setVelocity([0,0]);
plotSoccer(a4);

ball=plot(550,350,'wo','MarkerFaceColor','k');%足球

% B队
b1 = Player;
b1.Team = -1;
b1.headPosition =[950 350];
b1.setVelocity([0,0]);
plotSoccer(b1);

b2 = Player;
b2.Team = -1;
b2.headPosition =[850 350];
b2.setVelocity([0,0]);
plotSoccer(b2);

b3 = Player;
b3.Team = -1;
b3.headPosition =[680 200];
b3.setVelocity([0,0]);
plotSoccer(b3);


b4 = Player;
b4.Team = -1;
b4.headPosition =[680 500];
b4.setVelocity([0,0]);
plotSoccer(b4);



path_x = [0 : 1 : 1000];%横坐标
path_y1 = [0 : 1 : 700];        %第一只小燕子的飞行路线


hight = 1;%设定小燕子的初始高度
period = 5; %运动周期
k = 0;
len = length( path_x );

while k < period
   for i = 1 : len
        resetSoccer(a1,path_x(i),path_y1(i));
        pause(0.02);
   end
  path_x = fliplr( path_x );%逆向返回飞行
   k = k + 1;
end


hold off;
