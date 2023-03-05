clear all; clc;
close all;

% initial condition
ball = [1, 1, 10, 2];
m = 0.45;
g = 10;
mu = 0.3;
dt = 0.07;
a = [0, 0];

F = [0, 0];

% force outside
F_1 = 150;
lambda_1 = 90;

% simulation
for i = 1: 1: 10000
    if i > 1
        F_1 = 0;
        lambda_1 = 0;
    end
    [F] = f_calculation(m, g, mu, F_1, lambda_1, ball);
    [a] = a_calculation(F, m);
    [ball] = ball_controller(ball, a, dt);

    % vis
    plot(ball(1), ball(2), 'o')
    hold on
    axis([-200 200 -200 200])
    drawnow
end

% control
function [F] = f_calculation(m, g, mu, F_1, lambda_1, ball)
    theta = atan2(ball(4), ball(3));
    f_x = m*g*mu*cos(theta);
    f_y = m*g*mu*sin(theta);
    f_1_x = F_1*cosd(lambda_1);
    f_1_y = F_1*sind(lambda_1);
    F = [f_1_x - f_x, f_1_y - f_y];
end

function [a] = a_calculation(F, m)
    a(1) = F(1)/m;
    a(2) = F(2)/m;
end


function [new_ball] = ball_controller(ball, a, dt)
    new_ball(1) = ball(1) + ball(3)*dt;
    new_ball(2) = ball(2) + ball(4)*dt;
    new_ball(3) = ball(3) + a(1)*dt;
    new_ball(4) = ball(4) + a(2)*dt;
end
