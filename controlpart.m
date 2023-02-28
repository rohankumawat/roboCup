clear all; clc;

% goal
x_goal = 100;
x_goal_last = 100;
y_goal = 100;

% robot 1
x = 150;
y = 150;
theta = -160;
theta_last = theta;
theta_goal_last = atan2(y_goal - y, x_goal - x) * 180 / pi;
v = 0;
v_max = 0.3;

% pd controller variables
Kp = 7.5270;
Kd = 0.5;
dt = 0.01;
data = [];

% robot 2
x_1 = 1;
y_1 = 1;
theta_1 = 90;
v_1 = 0;
theta_1_last = theta_1;
theta_1_goal_last = atan2(y_goal - y_1, x_goal - x_1) * 180 / pi;


for i = 1: 1: 1000

    [x, y, theta, v, theta_goal_last, theta_last] = moveRobot_PD(x, y, theta, v, x_goal, y_goal, v_max, Kp, Kd, dt, x_goal_last, theta_last, theta_goal_last);
    [x_1, y_1, theta_1, v_1, theta_1_goal_last, theta_1_last, x_goal_last] = moveRobot_PD(x_1, y_1, theta_1, v_1, x_goal, y_goal, v_max, Kp, Kd, dt, x_goal_last, theta_1_last, theta_1_goal_last);
    data = [data;[x, y, theta, v]]; % store the data of robot 1

    % visulization
    plot(x, y, 'o')
    hold on
    plot(x_goal, y_goal, 'x')
    hold on
    plot(x_1, y_1, 'o')
    hold off
    axis([0 250 0 250])


    % move the ball
    x_goal = x_goal + 0.1;
    y_goal = y_goal - 0.1;
end


function [x_next, y_next, theta_next, v_next, theta_goal_last, theta_last, x_goal_last] = moveRobot_PD(x, y, theta, v, x_goal, y_goal, v_max, Kp, Kd, dt, x_goal_last, theta_last, theta_goal_last)
    
    d_x = x_goal - x; % calculate the distant to goal along x
    d_y = y_goal - y; % calculate the distant to goal along y
    theta_goal = atan2(d_y, d_x) * 180 / pi; % calculate the angle to the goal
    d_theta_goal = theta_goal_last - theta_goal;% calculate the dtheta_goal
    theta_goal_last = theta_goal;
    d_theta = theta_last - theta;% calculate the dtheta
    theta_last = theta;
    d_goal_x = x_goal_last - x_goal;% calculate the dx_goal
    x_goal_last = x_goal;
    
    e_x = abs(x_goal - x)-1.5;
    e_theta = theta_goal - theta;
    u_x = Kp * e_x + Kd * (d_goal_x/dt - cos(e_theta)); % calculate the line acceleration
    u_x = min(0.2, u_x);
    u_x = max(-1, u_x);
    u_theta = Kp * e_theta + Kd * (d_theta_goal - d_theta)/dt; % calculate the angle velocity

    % renew the velocity of the robot
    v_next = min(v_max, v + u_x * dt);
    v_next = max(v_next, 0);
    
    % renew the heading angle and the velocity
    theta_next = theta + u_theta * dt;
    x_next = x + v_next * cosd(theta_next);
    y_next = y + v_next * sind(theta_next);
end
