classdef UnityTool <handle

    %% PROPERTIES
    % Public (user-visible) properties
    properties
        initA1Pos = [150,350];
        initA1V = [0,0];
        
        initA2Pos = [270,200];
        initA2V = [0,0];
        
        initA3Pos = [270,500];
        initA3V = [0,0];
        
        initA4Pos = [420,350];
        initA4V = [0,0];
        
        % B队
        initB1Pos = [950,350];
        initB1V = [0,0];
        
        initB2Pos = [830,200];
        initB2V = [0,0];
        
        initB3Pos = [830,500];
        initB3V = [0,0];
        
        initB4Pos = [680,350];
        initB4V = [0,0];
        
        initBallPos = [550,350];
        initBallV = [0,0];
    end     
    methods
        function Init(obj,a1,a2,a3,a4,b1,b2,b3,b4,ball,cmCenter)
            a1.headPosition =obj.initA1Pos;
            a1.setVelocity(obj.initA1V);
            a1.headingAngle = 0;
            a1.V_total = 0;

            a2.headPosition = obj.initA2Pos;
            a2.setVelocity(obj.initA2V);
            a2.headingAngle = 0;
            a2.V_total = 0;

            a3.headPosition = obj.initA3Pos;
            a3.setVelocity(obj.initA3V);
            a3.headingAngle = 0;
            a3.V_total = 0;

            a4.headPosition = obj.initA4Pos;
            a4.setVelocity(obj.initA4V);
            a4.headingAngle=0;
            a4.V_total=0;

            value = rand([-1,1]);
            ball.Position = obj.initBallPos;
            if(value<0)
                 value = -50;
             else
                 value = 50;
             end
            ball.Position(1)=ball.Position(1)+value;
            ball.Velocity = obj.initBallV;
            ball.Holder = 0;

            b1.headPosition =obj.initB1Pos;
            b1.setVelocity(obj.initB1V);
            b1.headingAngle=180;
            b1.V_total=0;

            b2.headPosition =obj.initB2Pos;
            b2.setVelocity(obj.initB2V);
            b2.headingAngle=180;
            b2.V_total=0;

            b3.headPosition =obj.initB3Pos;
            b3.setVelocity(obj.initB3V);
            b3.headingAngle=180;
            b3.V_total=0;

            b4.headPosition =obj.initB4Pos;
            b4.setVelocity(obj.initB4V);
            b4.headingAngle=180;
            b4.V_total=0;

            cmCenter.addImfor(a1.returnMatrix,1);
            cmCenter.addImfor(a2.returnMatrix,2);
            cmCenter.addImfor(a3.returnMatrix,3);
            cmCenter.addImfor(a4.returnMatrix,4);
            cmCenter.addImfor(b1.returnMatrix,5);
            cmCenter.addImfor(b2.returnMatrix,6);
            cmCenter.addImfor(b3.returnMatrix,7);
            cmCenter.addImfor(b4.returnMatrix,8);
            cmCenter.addBallImfor(ball.returnMatrix);
        end

        function ballGoal(obj,a1,a2,a3,a4,b1,b2,b3,b4,ball,cmCenter,goalState)
            a1.headPosition =obj.initA1Pos;
            a1.setVelocity(obj.initA1V);
            a1.headingAngle = 0;
            a1.V_total = 0;

            a2.headPosition = obj.initA2Pos;
            a2.setVelocity(obj.initA2V);
            a2.headingAngle = 0;
            a2.V_total = 0;

            a3.headPosition = obj.initA3Pos;
            a3.setVelocity(obj.initA3V);
            a3.headingAngle = 0;
            a3.V_total = 0;

            a4.headPosition = obj.initA4Pos;
            a4.setVelocity(obj.initA4V);
            a4.headingAngle=0;
            a4.V_total=0;

            if (goalState == 1)
                value = 50;
            else
                value = -50;
            end
            ball.Position = obj.initBallPos;
            ball.Position(1)=ball.Position(1)+value;
            ball.Velocity = obj.initBallV;
            ball.Holder = 0;

            b1.headPosition =obj.initB1Pos;
            b1.setVelocity(obj.initB1V);
            b1.headingAngle=180;
            b1.V_total=0;

            b2.headPosition =obj.initB2Pos;
            b2.setVelocity(obj.initB2V);
            b2.headingAngle=180;
            b2.V_total=0;

            b3.headPosition =obj.initB3Pos;
            b3.setVelocity(obj.initB3V);
            b3.headingAngle=180;
            b3.V_total=0;

            b4.headPosition =obj.initB4Pos;
            b4.setVelocity(obj.initB4V);
            b4.headingAngle=180;
            b4.V_total=0;

            cmCenter.addImfor(a1.returnMatrix,1);
            cmCenter.addImfor(a2.returnMatrix,2);
            cmCenter.addImfor(a3.returnMatrix,3);
            cmCenter.addImfor(a4.returnMatrix,4);
            cmCenter.addImfor(b1.returnMatrix,5);
            cmCenter.addImfor(b2.returnMatrix,6);
            cmCenter.addImfor(b3.returnMatrix,7);
            cmCenter.addImfor(b4.returnMatrix,8);
            cmCenter.addBallImfor(ball.returnMatrix);
        end

        function ballOut(obj,a1,a2,a3,a4,b1,b2,b3,b4,ball,cmCenter,outState)
            if(outState == -1)
                if(ball.Position(1)<100)
                    ball.Position(1) = 101;
                else
                    ball.Position(1) = 999;
                end
                ball.Velocity = [-ball.Velocity(1)/5,ball.Velocity(2)/5];
            else
                if(ball.Position(2)<50)
                    ball.Position(2) = 51;
                else
                    ball.Position(2) = 649;
                end
                ball.Velocity = [ball.Velocity(1)/5,-ball.Velocity(2)/5];
            end
            ball.Holder = 0;

            cmCenter.addImfor(a1.returnMatrix,1);
            cmCenter.addImfor(a2.returnMatrix,2);
            cmCenter.addImfor(a3.returnMatrix,3);
            cmCenter.addImfor(a4.returnMatrix,4);
            cmCenter.addImfor(b1.returnMatrix,5);
            cmCenter.addImfor(b2.returnMatrix,6);
            cmCenter.addImfor(b3.returnMatrix,7);
            cmCenter.addImfor(b4.returnMatrix,8);
            cmCenter.addBallImfor(ball.returnMatrix);
        end
    end
end