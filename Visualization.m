classdef Visualization <handle
    %% PROPERTIES
    % Public (user-visible) properties
    properties
        player1;
        player2;
        player3;
        player4;
        player5;
        player6;
        player7;
        player8;
        ball;
    end     
    methods

        function setPlayers(obj,p1,p2,p3,p4,p5,p6,p7,p8,ball)
            %Team A,B,ball
            obj.player1 = p1;
            obj.player2 = p2;
            obj.player3 = p3;
            obj.player4 = p4;
            obj.player5 = p5;
            obj.player6 = p6;
            obj.player7 = p7;
            obj.player8 = p8;
            obj.ball = ball;
        end

        function plotSoccerField(obj)
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

            hold on;
        end

        function robot = plotSoccer(obj,soccer)
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

        function plotAllsoccer(obj)
            obj.plotSoccer(obj.player1);
            obj.plotSoccer(obj.player2);
            obj.plotSoccer(obj.player3);
            obj.plotSoccer(obj.player4);

            obj.plotSoccer(obj.player5);
            obj.plotSoccer(obj.player6);
            obj.plotSoccer(obj.player7);
            obj.plotSoccer(obj.player8); 
        end

        function plotBall(obj)
              position = obj.ball.Position;
              obj.ball.Handle = plot(position(1),position(2),'wo','MarkerFaceColor','k','MarkerSize',8);
        end

        function resetBall(obj,Xdata,Ydata)
            set(obj.ball.Handle,'Xdata',Xdata,'Ydata',Ydata);
        end

            
        function resetSoccer(obj,soccer,Xdata,Ydata)
           set( soccer.bodyHandle, 'Xdata', soccer.bodyPositionX,'Ydata', soccer.bodyPositionY);
           set( soccer.headHandle, 'Xdata', Xdata, 'Ydata',Ydata);
        end

        function resetAll(obj,p1Data,p2Data,p3Data,p4Data,p5Data,p6Data,p7Data,p8Data,ballData)
            obj.player1.headPosition = p1Data(1:2);
            obj.player1.setVelocity(p1Data(3:4));
            obj.resetSoccer(obj.player1,p1Data(1),p1Data(2));

            obj.player2.headPosition = p2Data(1:2);
            obj.player2.setVelocity(p2Data(3:4));
            obj.resetSoccer(obj.player2,p2Data(1),p2Data(2));

            obj.player3.headPosition = p3Data(1:2);
            obj.player3.setVelocity(p3Data(3:4));
            obj.resetSoccer(obj.player3,p3Data(1),p3Data(2));

            obj.player4.headPosition = p4Data(1:2);
            obj.player4.setVelocity(p4Data(3:4));
            obj.resetSoccer(obj.player4,p4Data(1),p4Data(2));

            obj.player5.headPosition = p5Data(1:2);
            obj.player5.setVelocity(p5Data(3:4));
            obj.resetSoccer(obj.player5,p5Data(1),p5Data(2));

            obj.player6.headPosition = p6Data(1:2);
            obj.player6.setVelocity(p6Data(3:4));
            obj.resetSoccer(obj.player6,p6Data(1),p6Data(2));

            obj.player7.headPosition = p7Data(1:2);
            obj.player7.setVelocity(p1Data(3:4));
            obj.resetSoccer(obj.player7,p7Data(1),p7Data(2));

            obj.player8.headPosition = p8Data(1:2);
            obj.player8.setVelocity(p8Data(3:4));
            obj.resetSoccer(obj.player8,p8Data(1),p8Data(2));

            obj.ball.Position = ballData(1:2);
            obj.ball.Velocity = ballData(3:4);
            obj.resetBall(ballData(1),ballData(2));
        end

    end
end