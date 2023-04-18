classdef CommunicateCenter <handle

    %% PROPERTIES
    % Public (user-visible) propertie
%soccer     PositionX,PositionY,VelocityX,VelocityY,heading_angle,Velocity
%ball       PositionX,PositionY,VelocityX,VelocityY
    properties
       robot1Pos = [];  %GoalKeeper
       robot2Pos = [];  %Defender1
       robot3Pos = [];  %Defender2
       robot4Pos = [];  %Striker
       robot5Pos = [];  %GoalKeeper
       robot6Pos = [];  %Defender1
       robot7Pos = [];  %Defender2
       robot8Pos = [];  %Striker
       ballPos = [];
       goalTime = [0,0,0];
    end

    methods

        function matrix = popImfor(obj,num)
            matrix = eval(['obj.robot',num2str(num), 'Pos']);
            [row,col] = size(matrix);
            if row >= 1
             matrix = matrix(row,:);
            else
                matrix = 0;
            end
        end

         function obj = addImfor(obj,imfor,num)
%             obj.robot1Pos = [obj.robot1Pos;imfor];
            eval(['obj.robot',num2str(num), 'Pos = [obj.robot',num2str(num),'Pos;imfor];']);
         end

         function matrix = popBallImfor(obj)
             [row,col] = size(obj.ballPos);
             if(row >=1)
                 matrix = obj.ballPos(row,:);
             else
                 matrix = 0;
             end
         end

         function obj = addBallImfor(obj,imfor)
             obj.ballPos = [obj.ballPos;imfor];
         end

         function obj = communicateWithDCMaker(obj,dcMaker)
            m1 = obj.popImfor(1);
            m2 = obj.popImfor(2);
            m3 = obj.popImfor(3);
            m4 = obj.popImfor(4);
            m5 = obj.popImfor(5);
            m6 = obj.popImfor(6);
            m7 = obj.popImfor(7);
            m8 = obj.popImfor(8);
            ball9 = obj.popBallImfor;
            
            dcMaker.positionAg = m1(1:2);
            dcMaker.positionAd1 = m2(1:2);
            dcMaker.positionAd2 = m3(1:2);
            dcMaker.positionAs = m4(1:2);
    
            dcMaker.positionBg = m5(1:2);
            dcMaker.positionBd1 = m6(1:2);
            dcMaker.positionBd2 = m7(1:2);
            dcMaker.positionBs = m8(1:2);

            dcMaker.positionBall = ball9(1:2);
    
            dcMaker.distance;
         end    
   
         function obj = communicateWithSImplement(obj,SImplement,holder,role)
            m1 = obj.popImfor(1);
            m2 = obj.popImfor(2);
            m3 = obj.popImfor(3);
            m4 = obj.popImfor(4);
            m5 = obj.popImfor(5);
            m6 = obj.popImfor(6);
            m7 = obj.popImfor(7);
            m8 = obj.popImfor(8);
            ball9 = obj.popBallImfor;
            
            SImplement.positionAg = m1(1:2);
            SImplement.positionAd1 = m2(1:2);
            SImplement.positionAd2 = m3(1:2);
            SImplement.positionAs = m4(1:2);
    
            SImplement.positionBg = m5(1:2);
            SImplement.positionBd1 = m6(1:2);
            SImplement.positionBd2 = m7(1:2);
            SImplement.positionBs = m8(1:2);
           
            SImplement.ball = ball9(1:4);
            SImplement.flag = holder;
            SImplement.role = role;
            SImplement.robotpos = [m4(1:2);m2(1:2);m3(1:2);m1(1:2);m8(1:2);m6(1:2);m7(1:2);m5(1:2)];
            
         end    
    end

end