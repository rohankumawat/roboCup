a1 = Player;    %GoalKeeper
a2 = Player;    %Defender1
a3 = Player;    %Defender2
a4 = Player;    %Striker

ball = Ball;

b1 = Player;    %GoalKeeper
b2 = Player;    %Defender1
b3 = Player;    %Defender2
b4 = Player;    %Striker

unTool = UnityTool;
cmCenter = CommunicateCenter;
dcMaker = DecisionMaker;
sImplement = StateImplement;
movement = robot;

unTool.Init(a1,a2,a3,a4,b1,b2,b3,b4,ball,cmCenter);

result = [];

a1.Team = 1;
a1.Role = 1;
p1_dot_vf=0;
p1_dot_lambda=0;

a2.Team = 1;
a2.Role = 2;
p2_dot_vf=0;
p2_dot_lambda=0;

a3.Team = 1;
a3.Role = 3;
p3_dot_vf=0;
p3_dot_lambda=0;

a4.Team = 1;
a4.Role = 4;
p4_dot_vf=0;
p4_dot_lambda=0;

% B队

b1.Team = -1;
b1.Role = 5;
p5_dot_vf=0;
p5_dot_lambda=0;

b2.Team = -1;
b2.Role = 6;
p6_dot_vf=0;
p6_dot_lambda=0;

b3.Team = -1;
b3.Role = 7;
p7_dot_vf=0;
p7_dot_lambda=0;

b4.Team = -1;
b4.Role = 8;
p8_dot_vf=0;
p8_dot_lambda=0;

% vslzt = Visualization;
% vslzt.plotSoccerField;
% vslzt.setPlayers(a1,a2,a3,a4,b1,b2,b3,b4,ball);
% vslzt.plotAllsoccer;
% vslzt.plotBall;


countGoal = 0;
countOut = 0;
steps = 3000; %30 = one minute 30 moves, 90 means the football game last for

for i= 1:1:steps
    cmCenter.communicateWithDCMaker(dcMaker);
    
    p1_state = dcMaker.state_decision(a1.Role,a1.headPosition(1),a1.headPosition(2),ball.Holder);
    p2_state = dcMaker.state_decision(a2.Role,a2.headPosition(1),a2.headPosition(2),ball.Holder);
    p3_state = dcMaker.state_decision(a3.Role,a3.headPosition(1),a3.headPosition(2),ball.Holder);
    p4_state = dcMaker.state_decision(a4.Role,a4.headPosition(1),a4.headPosition(2),ball.Holder);

    p5_state = dcMaker.state_decision(b1.Role,b1.headPosition(1),b1.headPosition(2),ball.Holder);
    p6_state = dcMaker.state_decision(b2.Role,b2.headPosition(1),b2.headPosition(2),ball.Holder);
    p7_state = dcMaker.state_decision(b3.Role,b3.headPosition(1),b3.headPosition(2),ball.Holder);
    p8_state = dcMaker.state_decision(b4.Role,b4.headPosition(1),b4.headPosition(2),ball.Holder);
    

    cmCenter.communicateWithSImplement(sImplement,ball.Holder,1);
    [newBallPos1,p1GoalPos]=sImplement.judge(p1_state);
    result = [result;p1_state,p2_state,p3_state,p4_state,p5_state,p6_state,p7_state,p8_state];
    
    cmCenter.communicateWithSImplement(sImplement,ball.Holder,2);
    [newBallPos2,p2GoalPos]=sImplement.judge(p2_state);
    
    cmCenter.communicateWithSImplement(sImplement,ball.Holder,3);
    [newBallPos3,p3GoalPos]=sImplement.judge(p3_state);
    
    cmCenter.communicateWithSImplement(sImplement,ball.Holder,4);
    [newBallPos4,p4GoalPos]=sImplement.judge(p4_state);
    
    cmCenter.communicateWithSImplement(sImplement,ball.Holder,5);
    [newBallPos5,p5GoalPos]=sImplement.judge(p5_state);
    
    cmCenter.communicateWithSImplement(sImplement,ball.Holder,6);
    [newBallPos6,p6GoalPos]=sImplement.judge(p6_state);
    
    cmCenter.communicateWithSImplement(sImplement,ball.Holder,7);
    [newBallPos7,p7GoalPos]=sImplement.judge(p7_state);
    
    cmCenter.communicateWithSImplement(sImplement,ball.Holder,8);
    [newBallPos8,p8GoalPos]=sImplement.judge(p8_state);
    
    newBallPos = ball.returnMatrix;
    
    if newBallPos(3) ~= newBallPos1(3) || newBallPos(4) ~= newBallPos1(4)
        newBallPos = newBallPos1;
    elseif newBallPos(3) ~= newBallPos2(3) || newBallPos(4) ~= newBallPos2(4)
        newBallPos = newBallPos2;
    elseif newBallPos(3) ~= newBallPos3(3) || newBallPos(4) ~= newBallPos3(4)
        newBallPos = newBallPos3;
    elseif newBallPos(3) ~= newBallPos4(3) || newBallPos(4) ~= newBallPos4(4)
        newBallPos = newBallPos4;
    elseif newBallPos(3) ~= newBallPos5(3) || newBallPos(4) ~= newBallPos5(4)
        newBallPos = newBallPos5;
    elseif newBallPos(3) ~= newBallPos6(3) || newBallPos(4) ~= newBallPos6(4)
        newBallPos = newBallPos6;
    elseif newBallPos(3) ~= newBallPos7(3) || newBallPos(4) ~= newBallPos7(4)
        newBallPos = newBallPos7;
    elseif newBallPos(3) ~= newBallPos8(3) || newBallPos(4) ~= newBallPos8(4)
        newBallPos = newBallPos8;
    else
         newBallPos = sImplement.non_force();
    end

    newPosP1 = cmCenter.popImfor(1);
    movement.update(newPosP1,p1_dot_vf,p1_dot_lambda,p1GoalPos);
    [p1_dot_vf,p1_dot_lambda,newPosP1]=movement.robot_control;

    
    newPosP2 = cmCenter.popImfor(2);
    movement.update(newPosP2,p2_dot_vf,p2_dot_lambda,p2GoalPos);
    [p2_dot_vf,p2_dot_lambda,newPosP2]=movement.robot_control;
    
    newPosP3 = cmCenter.popImfor(3);
    movement.update(newPosP3,p3_dot_vf,p3_dot_lambda,p3GoalPos);
    [p3_dot_vf,p3_dot_lambda,newPosP3]=movement.robot_control;
    
    newPosP4 = cmCenter.popImfor(4);
    movement.update(newPosP4,p4_dot_vf,p4_dot_lambda,p4GoalPos);
    [p4_dot_vf,p4_dot_lambda,newPosP4]=movement.robot_control;

    newPosP5 = cmCenter.popImfor(5);
    movement.update(newPosP5,p5_dot_vf,p5_dot_lambda,p5GoalPos);
    [p5_dot_vf,p5_dot_lambda,newPosP5]=movement.robot_control;
    
    newPosP6 = cmCenter.popImfor(6);
    movement.update(newPosP6,p6_dot_vf,p6_dot_lambda,p6GoalPos);
    [p6_dot_vf,p6_dot_lambda,newPosP6]=movement.robot_control;
    
    newPosP7 = cmCenter.popImfor(7);
    movement.update(newPosP7,p7_dot_vf,p7_dot_lambda,p7GoalPos);
    [p7_dot_vf,p7_dot_lambda,newPosP7]=movement.robot_control;
    
    newPosP8 = cmCenter.popImfor(8);
    movement.update(newPosP8,p8_dot_vf,p8_dot_lambda,p8GoalPos);
    [p8_dot_vf,p8_dot_lambda,newPosP8]=movement.robot_control;
    
    cmCenter.addImfor(newPosP1,1);
    cmCenter.addImfor(newPosP2,2);
    cmCenter.addImfor(newPosP3,3);
    cmCenter.addImfor(newPosP4,4);
    cmCenter.addImfor(newPosP5,5);
    cmCenter.addImfor(newPosP6,6);
    cmCenter.addImfor(newPosP7,7);
    cmCenter.addImfor(newPosP8,8);
    cmCenter.addBallImfor(newBallPos);

    a1.headPosition = [newPosP1(1),newPosP1(2)];
    a1.setVelocity([newPosP1(3),newPosP1(4)]);
    a1.headingAngle = newPosP1(5);
    a1.V_total = newPosP1(6);

    a2.headPosition = [newPosP2(1),newPosP2(2)];
    a2.setVelocity([newPosP2(3),newPosP2(4)]);
    a2.headingAngle = newPosP2(5);
    a2.V_total = newPosP2(6);

    a3.headPosition = [newPosP3(1),newPosP3(2)];
    a3.setVelocity([newPosP3(3),newPosP3(4)]);
    a3.headingAngle = newPosP3(5);
    a3.V_total = newPosP3(6);

    a4.headPosition = [newPosP4(1),newPosP4(2)];
    a4.setVelocity([newPosP4(3),newPosP4(4)]);
    a4.headingAngle = newPosP4(5);
    a4.V_total = newPosP4(6);

    b1.headPosition = [newPosP5(1),newPosP5(2)];
    b1.setVelocity([newPosP5(3),newPosP5(4)]);
    b1.headingAngle = newPosP5(5);
    b1.V_total = newPosP5(6);

    b2.headPosition = [newPosP6(1),newPosP6(2)];
    b2.setVelocity([newPosP6(3),newPosP6(4)]);
    b2.headingAngle = newPosP6(5);
    b2.V_total = newPosP6(6);

    b3.headPosition = [newPosP7(1),newPosP7(2)];
    b3.setVelocity([newPosP7(3),newPosP7(4)]);
    b3.headingAngle = newPosP7(5);
    b3.V_total = newPosP7(6);

    b4.headPosition = [newPosP8(1),newPosP8(2)];
    b4.setVelocity([newPosP8(3),newPosP8(4)]);
    b4.headingAngle = newPosP8(5);
    b4.V_total = newPosP8(6);

    ball.Position = [newBallPos(1),newBallPos(2)];
    ball.Velocity = [newBallPos(3),newBallPos(4)];
    ball.Holder = dcMaker.distance;
    
    goalState = ball.whetherGoal;
    if goalState == 1 ||goalState == -1
        unTool.ballGoal(a1,a2,a3,a4,b1,b2,b3,b4,ball,cmCenter,goalState);

        p1_dot_vf=0;
        p1_dot_lambda=0;

        p2_dot_vf=0;
        p2_dot_lambda=0;

        p3_dot_vf=0;
        p3_dot_lambda=0;

        p4_dot_vf=0;
        p4_dot_lambda=0;

        p5_dot_vf=0;
        p5_dot_lambda=0;

        p6_dot_vf=0;
        p6_dot_lambda=0;

        p7_dot_vf=0;
        p7_dot_lambda=0;

        p8_dot_vf=0;
        p8_dot_lambda=0;
        
        countGoal = countGoal +1;
        goalLen = size(cmCenter.goalTime,1);
        if goalState == 1
            cmCenter.goalTime = [cmCenter.goalTime;[i,cmCenter.goalTime(goalLen,2)+1,cmCenter.goalTime(goalLen,3)]];
        end
        if goalState == -1    
            cmCenter.goalTime = [cmCenter.goalTime;[i,cmCenter.goalTime(goalLen,2),cmCenter.goalTime(goalLen,3)+1]];
        end
    end

    if ball.whetherOut == 1 || ball.whetherOut == -1
        unTool.ballOut(a1,a2,a3,a4,b1,b2,b3,b4,ball,cmCenter,ball.whetherOut);

    end
end

