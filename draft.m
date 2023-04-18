fig = figure();
vslz = Visualization;
vslz.plotSoccerField;
vslz.setPlayers(a1,a2,a3,a4,b1,b2,b3,b4,ball);
vslz.plotAllsoccer;
vslz.plotBall;
len = size(cmCenter.ballPos,1);
goalLen = size(cmCenter.goalTime,1);
goalIndex = -1;

slider = uicontrol('Parent', fig, 'Style', 'slider', 'Units', 'normalized', ...
    'Position', [0.115 0.0 0.8 0.05], 'Min', 0, 'Max', len, 'Value', 0);


% 定义滑块的回调函数，每当滑块的值发生变化时就会调用该函数
set(slider, 'Callback', {@slider_callback});


for i=1:len
    pause(0.02);
    for j=1:goalLen
        if(i>=cmCenter.goalTime(j))
            if(j+1>goalLen)
                goalIndex = j;
            else
               if(i<cmCenter.goalTime(j+1))
                  goalIndex = j;
                  break
               end
            end
        end
    end

    Ascore = cmCenter.goalTime(goalIndex,2);
    Bscore = cmCenter.goalTime(goalIndex,3);
    title(Ascore+":"+Bscore);

    i=round(get(slider,'Value'))+1;
    
    set(slider,'Value',i);

    vslz.resetAll([cmCenter.robot1Pos(i,:)],[cmCenter.robot2Pos(i,:)],[cmCenter.robot3Pos(i,:)],[cmCenter.robot4Pos(i,:)],[cmCenter.robot5Pos(i,:)], ...
        [cmCenter.robot6Pos(i,:)],[cmCenter.robot7Pos(i,:)],[cmCenter.robot8Pos(i,:)],[cmCenter.ballPos(i,:)])
end

% 定义滑块的回调函数
function slider_callback(slider,event)
    pause(0.2);
    value = get(slider, 'Value');
    set(slider,'Value',value);
end