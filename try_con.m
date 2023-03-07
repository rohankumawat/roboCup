clc; clear all;
close all;
ball = [10, 10, 0, 0];
robot_1 = [1, 10, 0, 0, 90, 0];
a = kick;
% simulation
for i = 1: 1: 1111
    if abs(ball(1)-robot_1(1))<=3
        ball = a.keep(ball, robot_1);
    else
        ball = a.non_force(ball, robot_1);
    end


    % vis
    plot(ball(1), ball(2), 'o')
    hold on
    plot(robot_1(1), robot_1(2), 'o')
    hold off
    axis([0 200 0 200])
    drawnow

    robot_1(1) = robot_1(1) + 0.1;
end




