function robot = plotSoccer(soccer)
    if soccer.Team == 1
        color = 'r';
    else
        color = 'b';
    end
    x = soccer.bodyPositionX;
    y = soccer.bodyPositionY;
    head=plot(soccer.headPosition(1),soccer.headPosition(2),'ro','MarkerFaceColor',color,'MarkerSize',10);%a_goalkeeper
    body = plot(x, y,color,LineWidth=2);
    soccer.headHandle = head;
    soccer.bodyHandle = body;
    robot = [head,body];
end

