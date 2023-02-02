figure('color','[0.13 0.55 0.13]')
% Title
title('Soccer Field','Color','w');

% Line
xline(55,'w-','LineWidth',2);

% Draw the boundary
rectangle('Position', [0 0 110 80],'LineWidth', 2,'FaceColor','w','EdgeColor','w');
rectangle('Position', [10 10 90 60],'LineWidth', 2 ,'FaceColor','[0.13 0.55 0.13]','EdgeColor','w');

rectangle('Position', [10 15 20 50],'LineWidth', 2,'EdgeColor','w');
rectangle('Position', [10 25 10 30],'LineWidth', 2,'EdgeColor','w');
rectangle('Position', [80 15 20 50],'LineWidth', 2,'EdgeColor','w');
rectangle('Position', [90 25 10 30],'LineWidth', 2,'EdgeColor','w');
rectangle('Position', [4 27 6 26],'LineWidth', 2,'EdgeColor','r','FaceColor','r');
rectangle('Position', [100 27 6 26],'LineWidth', 2,'EdgeColor','b','FaceColor','b');

% Center circle
viscircles([55 40],7.5,'Color','w');

% Remove default labels and ticks
xlabel('');
ylabel('');
yticks('');
xticks('');

% Crop to field dimensions
axis equal
xlim([0 110]);
ylim([0 80]);

hold off
