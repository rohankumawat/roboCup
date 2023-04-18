classdef DecisionMaker <handle

    %% PROP                     RTIES
    % Public (Player) properties
    properties
        positionAs = [0,0];
        dAs = 0;
        positionAd1 = [0,0];
        dAd1 = 0;
        positionAd2 = [0,0];
        dAd2 = 0;
        positionAg = [0,0];
        dAg = 0;

        positionBs = [0,0];
        dBs = 0;
        positionBd1 = [0,0];
        dBd1 = 0;
        positionBd2 = [0,0];
        dBd2 = 0;
        positionBg = [0,0];
        dBg = 0;

        positionBall = [0, 0];

    end     
    methods
        %state: 1.pass  2.shoot 3.red carry  4.around  5.defend 6.back 7.blue carry
        function fg = distance(obj)  %distance between each player and ball
                obj.dAs = sqrt((obj.positionBall(1)-obj.positionAs(1))^2+(obj.positionBall(2)-obj.positionAs(2))^2);
                obj.dAd1 = sqrt((obj.positionBall(1)-obj.positionAd1(1))^2+(obj.positionBall(2)-obj.positionAd1(2))^2);
                obj.dAd2 = sqrt((obj.positionBall(1)-obj.positionAd2(1))^2+(obj.positionBall(2)-obj.positionAd2(2))^2);
                obj.dAg = sqrt((obj.positionBall(1)-obj.positionAg(1))^2+(obj.positionBall(2)-obj.positionAg(2))^2);

                obj.dBs = sqrt((obj.positionBall(1)-obj.positionBs(1))^2+(obj.positionBall(2)-obj.positionBs(2))^2);
                obj.dBd1 = sqrt((obj.positionBall(1)-obj.positionBd1(1))^2+(obj.positionBall(2)-obj.positionBd1(2))^2);
                obj.dBd2 = sqrt((obj.positionBall(1)-obj.positionBd2(1))^2+(obj.positionBall(2)-obj.positionBd2(2))^2);
                obj.dBg = sqrt((obj.positionBall(1)-obj.positionBg(1))^2+(obj.positionBall(2)-obj.positionBg(2))^2);
                value = [obj.dAg, obj.dAd1, obj.dAd2, obj.dAs, obj.dBg, obj.dBd1, obj.dBd2, obj.dBs];
                [min_value, min_indx] = min(value);
                if min_value <= 15
                    fg = min_indx;
                else
                    fg = 0;
                end
        end


        function updatePos(obj, positionAs, positionAd1, positionAd2, positionAg, positionBs, positionBd1, positionBd2, positionBg, positionBall)
                obj.positionAs = positionAs;
                obj.positionAd1 = positionAd1;
                obj.positionAd2 = positionAd2;
                obj.positionAg = positionAg;
                obj.positionBs = positionBs;
                obj.positionBd1 = positionBd1;
                obj.positionBd2 = positionBd2;
                obj.positionBg = positionBg;
                obj.positionBall = positionBall;

        end
        function state = state_decision(obj, role, xrobot, yrobot, flag)    %current player role，position, orientation，player who control the ball
            r = sqrt((obj.positionBall(1)-xrobot)^2+(obj.positionBall(2)-yrobot)^2);
            if (role <= 4 && flag >4)  || (role>4 && flag>=1 && flag<=4)       %enemy control ball, defend
                if role ~= 1 && flag == 1 && role~=5
                    state = 6;
                elseif role ~= 5 && flag == 5 && role~=1
                    state = 6;
                else
                    if role <= 4 %current player is red
                        if r<=obj.dAs && r<=obj.dAd1 && r<=obj.dAd2 && role~=1   %current player is red, not a goalkeeper and the closest player
                            state = 5;  %defend
                        elseif obj.dAg<250 && role==1 && obj.positionAg(1) < 300   %current player: goalkeeper, distance less than 150 between him and ball
                            state = 5;    %goalkeeper to defend
                        else
                            state = 4;    %run randomly in pitch
                        end
                    else %current player is blue
                        if r<=obj.dBs && r<=obj.dBd1 && r<=obj.dBd2 && role~=5  %current player is blue, not a goalkeeper and the closest player
                            state = 5;  %defend
                        elseif obj.dBg<250 && role==5 && obj.positionBg(1) > 800  %current player: goalkeeper, distance less than 150 between him and ball
                            state = 5;    %goalkeeper to defend
                        else 
                            state = 4;    %run randomly in pitch
                        end
                    end
                end 

            elseif(role<=4 && flag<=4 && flag>=1) || (role>4 && flag >4)    %control ball ourselves   1goalkeeper，2、3defender，4striker
                if role==4 || role==8  %current role is striker
                    if role==4 && flag==4  %red striker holds ball
                        if (obj.dBd1 <=40 && obj.positionBd1(1)>obj.positionAs(1)) || (obj.dBd2<=40 && obj.positionBd2(1)>obj.positionAs(1))
                            state  = 1;%Enemy's defenders are ahead and the distance less than 40, pass
                        elseif obj.dBg <= 320
                            state = 2;%The distance between ball and blue goalkeeper less than 220, shoot
                        else
                            state = 3;%Red Carry ball
                        end
                    elseif role==8 && flag==8 %Blue striker holds ball
                        if (obj.dAd1 <=40 && obj.positionBs(1)>obj.positionAd1(1)) || (obj.dAd2<=40 && obj.positionBs(1)>obj.positionAd2(1))
                            state  = 1;%Enemy's defenders are ahead and the distance less than 40, pass
                        elseif obj.dAg <= 320
                            state = 2;%The distance between ball and red goalkeeper less than 220, shoot
                        else 
                            state = 7;%Blue Carry ball
                        end
                    else
                        state = 4;%Striker doesn't hold ball and runs around
                    end

                elseif role==2 || role==3 || role==6 || role ==7 %Current player is defender
                    if role==2 && flag==2  %Red defender 2 holds ball, and current player is 2
                        if ((obj.positionBs(1) > obj.positionAd1(1)) && (obj.dBs <= 40)) || ((obj.positionBd1(1) > obj.positionAd1(1)) && (obj.dBd1<=40)) || ((obj.positionBd2(1) > obj.positionAd1(1)) && (obj.dBd2<=40))
                            state = 1;%Enemy's striker and defenders are ahead and the distance less than 40, pass
                        else
                            state = 3;%Carry ball
                        end
                    elseif role==3 && flag==3   %Red defender 3 holds ball, and current player is 3
                        if ((obj.positionBs(1) > obj.positionAd2(1)) && (obj.dBs <= 40)) || ((obj.positionBd1(1) > obj.positionAd2(1)) && (obj.dBd1<=40)) || ((obj.positionBd2(1) > obj.positionAd2(1)) && (obj.dBd2<=40))
                            state = 1;%Enemy's striker and defenders are ahead and the distance less than 40, pass
                        else
                            state = 3;%Carry ball
                        end
                    elseif role==6 && flag==6   %Blue defender 6 holds ball, and current role is 6
                        if ((obj.positionAs(1) < obj.positionBd1(1)) && (obj.dAs <= 40)) || ((obj.positionAd1(1) > obj.positionBd1(1)) && (obj.dAd1<=40)) || ((obj.positionAd2(1) > obj.positionBd1(1)) && (obj.dAd2<=40))
                            state = 1;%Enemy's striker and defenders are ahead and the distance less than 40, pass
                        else
                            state = 7;%Carry ball
                        end
                    elseif role==7 && flag==7 %Blue defender 7 holds ball, and current role is 7
                        if ((obj.positionAs(1) < obj.positionBd2(1)) && (obj.dAs <= 40)) || ((obj.positionAd1(1) > obj.positionBd1(1)) && (obj.dAd1<=40)) || ((obj.positionAd2(1) > obj.positionBd1(1)) && (obj.dAd2<=40))
                            state = 1;%Enemy's striker and defenders are ahead and the distance less than 40, pass
                        else
                            state = 7;%Carry ball
                        end
                    else
                        state = 4;%Defender doesn't hold ball, around
                    end
                else %Current role isGoalkeeper
                    if role==1 && flag==1   %Current role is red goalkeeper and holds ball
                        state = 1;
                    elseif role==5 && flag==5   %Current role is blue goalkeeper and hold ball
                        state = 1;
                    else
                        state =4;
                    end
                end

            else %Ball is out of control for all players
                if r < 300
                    state = 5;
                else
                    state = 4;
                end 
            end
        end
    end
end
