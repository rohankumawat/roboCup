classdef kick 

    properties
        t = 0.05;
        angle = 0;
        F_keep = 60;
        m = 0.45;
        g = 10; 
        mu = 0.3;
        dt = 0.05;
        F_non = 0;
        lambda_non = 0;
        F_shoot = 400;
    end

    methods

        function [new_ball] = shoot(obj, ball)
            y_num = randi([220, 480]);
            if ball(1) <= 550
                x_num = 100;
            else
                x_num = 1000;
            end
            goal = [x_num, y_num]
            F_angle = obj.shoot_angle(ball, goal);
            F = obj.f_calculation(obj.m, obj.g, obj.mu, obj.F_shoot, F_angle, ball);
            a = obj.a_calculation(F, obj.m);
            new_ball = obj.ball_controller(ball, a, obj.dt); 
        end

        function [new_ball] = pass(obj, ball, robot_pass, robot_receive)
        end

        function [ball_angle] = shoot_angle(obj, ball, goal)

            ball_angle = atan2(goal(2)-ball(2), goal(1)-ball(1))*180/pi
%             theta = atan2(ball(4), ball(3))
% 
%             f_x = obj.m*obj.g*obj.mu*cos(theta);
%             f_y = obj.m*obj.g*obj.mu*sin(theta);
% 
%             if ball(3)==0 && ball(4)==0
%                 f_x = 0;
%                 f_y = 0;
%             end
%             F_angle = atand(f_y - f_x*tan(ball_angle), obj.F_shoot*cos(ball_angle) - f_x)

        end

        function [new_ball] = non_force(obj, ball)
            F = obj.f_calculation(obj.m, obj.g, obj.mu, obj.F_non, obj.lambda_non, ball);
            if ball(3) == 0 && ball(4) == 0
                F = [0, 0];
            end
            a = obj.a_calculation(F, obj.m);
            new_ball = obj.ball_controller(ball, a, obj.dt);  
        end

        function [new_ball] = keep(obj, ball, robot)
            lambda = obj.angle_cal(ball, robot);
            F = obj.f_calculation(obj.m, obj.g, obj.mu, obj.F_keep, lambda, ball);
            a = obj.a_calculation(F, obj.m);
            new_ball = obj.ball_controller(ball, a, obj.dt);  
        end

        function [angle] = angle_cal(obj, ball, robot)
            angle = atan2(ball(2) - robot(2), ball(1) - robot(1))*180/pi;
        end

        function [F] = f_calculation(obj, m, g, mu, F_keep, lambda_1, ball)
            theta = atan2(ball(4), ball(3));
            f_x = m*g*mu*cos(theta);
            f_y = m*g*mu*sin(theta);
            f_1_x = F_keep*cosd(lambda_1);
            f_1_y = F_keep*sind(lambda_1);
            F = [f_1_x - f_x, f_1_y - f_y];
        end

        function [a] = a_calculation(obj, F, m)
            a(1) = F(1)/m;
            a(2) = F(2)/m;
        end

        function [new_ball] = ball_controller(obj, ball, a, dt)
            new_ball(1) = ball(1) + ball(3)*dt;
            new_ball(2) = ball(2) + ball(4)*dt;
            new_ball(3) = ball(3) + a(1)*dt;
            new_ball(4) = ball(4) + a(2)*dt;
        end
    end
end