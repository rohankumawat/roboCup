classdef StateImplement <handle

    properties
        t = 0.02;
        angle = 0;
        m = 0.45;
        g = 10; 
        mu = 0.3;
        dt = 0.02;
        F_non = 0;
        f_co = 1000;
        lambda_non = 0;
        F_carry = 1000;
        F_pass = 3000;
        F_shoot = 2500;
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

        robotpos = [[0,0];[0,0];[0,0];[0,0];[0,0];[0,0];[0,0];[0,0]];
        current = [0,0];
        flag = 1;
        role = 1;       %当前的球员角色
        ball = [0, 0, 0, 0];
    end

    methods

        function value = distance(obj)  %distance between each player and ball
            obj.dAs = sqrt((obj.ball(1)-obj.positionAs(1))^2+(obj.ball(2)-obj.positionAs(2))^2);
            obj.dAd1 = sqrt((obj.ball(1)-obj.positionAd1(1))^2+(obj.ball(2)-obj.positionAd1(2))^2);
            obj.dAd2 = sqrt((obj.ball(1)-obj.positionAd2(1))^2+(obj.ball(2)-obj.positionAd2(2))^2);
            obj.dAg = sqrt((obj.ball(1)-obj.positionAg(1))^2+(obj.ball(2)-obj.positionAg(2))^2);

            obj.dBs = sqrt((obj.ball(1)-obj.positionBs(1))^2+(obj.ball(2)-obj.positionBs(2))^2);
            obj.dBd1 = sqrt((obj.ball(1)-obj.positionBd1(1))^2+(obj.ball(2)-obj.positionBd1(2))^2);
            obj.dBd2 = sqrt((obj.ball(1)-obj.positionBd2(1))^2+(obj.ball(2)-obj.positionBd2(2))^2);
            obj.dBg = sqrt((obj.ball(1)-obj.positionBg(1))^2+(obj.ball(2)-obj.positionBg(2))^2);
            value = [obj.dAg, obj.dAd1, obj.dAd2, obj.dAs, obj.dBg, obj.dBd1, obj.dBd2, obj.dBs];           
        end

        function updatePos(obj, role, flag, positionAs, positionAd1, positionAd2, positionAg, positionBs, positionBd1, positionBd2, positionBg, ball)
            obj.positionAs = positionAs;
            obj.positionAd1 = positionAd1;
            obj.positionAd2 = positionAd2;
            obj.positionAg = positionAg;
            obj.positionBs = positionBs;
            obj.positionBd1 = positionBd1;
            obj.positionBd2 = positionBd2;
            obj.positionBg = positionBg;

            obj.ball = ball;
            obj.flag = flag;
            obj.role = role;
            obj.robotpos = [positionAg; positionAd1; positionAd2; positionAs; positionBg; positionBd1; positionBd2; positionBs];
        end
        
        function [newball, targetpos] = judge(obj, state)  %state: 1.pass  2.shoot 3.carry  4.around  5.defend
            if state == 1
                [newball, targetpos] = obj.pass();
            elseif state == 2
                [newball, targetpos] = obj.shoot();
            elseif state == 3
                [newball, targetpos] = obj.carry_1();
            elseif state == 4
                [newball, targetpos] = obj.around();
            elseif state == 7
                [newball, targetpos] = obj.carry_2();
            elseif state == 6
                [newball, targetpos] = obj.back();
            else 
                [newball, targetpos] = obj.defend();
            end
        end


        function [newball,targetpos] = pass(obj)    %pass  ball
            if obj.flag<=4 && obj.flag>=1
                rdn = randi([2,4]);
                while rdn == obj.role
                    rdn = randi([2,4]);
                end
            else
                rdn = randi([6,8]);
                while rdn == obj.role
                    rdn = randi([6,8]);
                end
            end
            obj.robotpos(rdn,:)
            agl = obj.shoot_angle(obj.robotpos(rdn,:));
            va = obj.distance();
            if va(obj.flag) > 1
                f_r = obj.F_pass/va(obj.flag);
            else
                f_r = obj.F_pass;
            end
            F = obj.f_calculation(agl, f_r);
            a = obj.a_calculation(F);
            newball = obj.ball_controller(a);
            collision = obj.ball_collision(newball);
            if collision ~= 0
                angle_1 = atan2(obj.ball(2) - obj.robotpos(collision, 2), obj.ball(1) - obj.robotpos(collision, 1))*180/pi;
                f_c = obj.f_calculation(angle_1, obj.f_co);
                a_c = obj.a_calculation(f_c);
                newball = obj.ball_controller(a_c);
            end
            targetpos = [obj.ball(1), obj.ball(2)];
        end

        function [new_ball,targetpos] = shoot(obj)    %shoot ball
            y_num = randi([220, 480]);
            if obj.ball(1) <= 550
                x_num = 100;
            else
                x_num = 1000;
            end
            goal = [x_num, y_num];
            F_angle = obj.shoot_angle(goal);
            va = obj.distance();
            if va(obj.flag) > 1
                f_r = obj.F_shoot/va(obj.flag);
            else
                f_r = obj.F_shoot;
            end
            F = obj.f_calculation(F_angle, f_r);
            a = obj.a_calculation(F);
            new_ball = obj.ball_controller(a);
            collision = obj.ball_collision(new_ball);
            if collision ~= 0
                angle_1 = atan2(obj.ball(2) - obj.robotpos(collision, 2), obj.ball(1) - obj.robotpos(collision, 1))*180/pi;
                f_c = obj.f_calculation(angle_1, obj.f_co);
                a_c = obj.a_calculation(f_c);
                new_ball = obj.ball_controller(a_c);
            end
            targetpos = [obj.ball(1), obj.ball(2)];
        end

        function [new_ball,targetpos] = carry_2(obj)  %carry ball
            y_num = randi([150, 550]);
            x_num = 100;
            goal = [x_num, y_num];
            F_angle = obj.shoot_angle(goal);
            va = obj.distance();
            if va(obj.flag) > 1
                f_r = obj.F_carry/va(obj.flag);
            else
                f_r = obj.F_carry;
            end
            F = obj.f_calculation(F_angle, f_r);
            a = obj.a_calculation(F);
            new_ball = obj.ball_controller(a);
            collision = obj.ball_collision(new_ball);
            if collision ~= 0
                angle_1 = atan2(obj.ball(2) - obj.robotpos(collision, 2), obj.ball(1) - obj.robotpos(collision, 1))*180/pi;
                f_c = obj.f_calculation(angle_1, obj.f_co);
                a_c = obj.a_calculation(f_c);
                new_ball = obj.ball_controller(a_c);
            end
            targetpos = [obj.ball(1), obj.ball(2)];
        end

        function [new_ball,targetpos] = carry_1(obj)  %carry ball
            y_num = randi([150, 550]);
            x_num = 1000;
            goal = [x_num, y_num];
            F_angle = obj.shoot_angle(goal);
            va = obj.distance();
            if va(obj.flag) > 1
                f_r = obj.F_carry / va(obj.flag);
            else
                f_r = obj.F_carry;
            end
            F = obj.f_calculation(F_angle, f_r);
            a = obj.a_calculation(F);
            new_ball = obj.ball_controller(a);
            collision = obj.ball_collision(new_ball);
            if collision ~= 0
                angle_1 = atan2(obj.ball(2) - obj.robotpos(collision, 2), obj.ball(1) - obj.robotpos(collision, 1))*180/pi;
                f_c = obj.f_calculation(angle_1, obj.f_co);
                a_c = obj.a_calculation(f_c);
                new_ball = obj.ball_controller(a_c);
            end
            targetpos = [obj.ball(1), obj.ball(2)];

        end

        function [new_ball,targetpos] = around(obj)   %around with no ball
            rdy = randi([50, 650]);
            if obj.role == 2 || obj.role == 3 || obj.role== 8  %如果是red后卫或blue前锋
                rdx = randi([100,600]);
            elseif obj.role == 4 || obj.role == 6 || obj.role== 7 %如果是blue后卫或red前锋
                rdx = randi([600,1100]);
            elseif obj.role == 1
                rdx = randi([100,170]);
                rdy = randi([300,400]);
            else
                rdx = randi([930,1000]);
                rdy = randi([300,400]);
            end
            targetpos = [rdx, rdy];

            new_ball = obj.ball;
            collision = obj.ball_collision(new_ball);
            if collision ~= 0
                angle_1 = atan2(obj.ball(2) - obj.robotpos(collision, 2), obj.ball(1) - obj.robotpos(collision, 1))*180/pi;
                f_c = obj.f_calculation(angle_1, obj.f_co);
                a_c = obj.a_calculation(f_c);
                new_ball = obj.ball_controller(a_c);
            end
        end

        function [new_ball,targetpos] = defend(obj) %go to defend
            targetpos = [obj.ball(1), obj.ball(2)];
            new_ball = obj.ball;
            collision = obj.ball_collision(new_ball);
            if collision ~= 0
                angle_1 = atan2(obj.ball(2) - obj.robotpos(collision, 2), obj.ball(1) - obj.robotpos(collision, 1))*180/pi;
                f_c = obj.f_calculation(angle_1, obj.f_co);
                a_c = obj.a_calculation(f_c);
                new_ball = obj.ball_controller(a_c);
            end
        end


        function new_ball = non_force(obj)  %ball action
            F = obj.f_calculation(obj.lambda_non, obj.F_non);
            if obj.ball(3) == 0 && obj.ball(4) == 0
                F = [0, 0];
            end
            a = obj.a_calculation(F);
            if sqrt(obj.ball(3)^2 + obj.ball(4)^2) <= 0.15
                obj.ball(3) = 0;
                obj.ball(4) = 0;
                a = [0, 0];
            elseif abs(obj.ball(3)) <= 0.15
                obj.ball(3) = 0;
                a(1) = 0;
            elseif abs(obj.ball(4)) <= 0.15
                obj.ball(4) = 0;
                a(2) = 0;
            end
            new_ball = obj.ball_controller(a);  
            collision = obj.ball_collision(new_ball);
            if collision ~= 0
                angle_1 = atan2(obj.ball(2) - obj.robotpos(collision, 2), obj.ball(1) - obj.robotpos(collision, 1))*180/pi;
                f_c = obj.f_calculation(angle_1, obj.f_co);
                a_c = obj.a_calculation(f_c);
                new_ball = obj.ball_controller(a_c);
            end
        end

        function angle = angle_cal(obj)
            angle = atan2(obj.ball(2) - obj.robotpos(obj.role, 2), obj.ball(1) - obj.robotpos(obj.role, 1))*180/pi;
        end

        function [ball_angle] = shoot_angle(obj, goal)  
            ball_angle = atan2(goal(2)-obj.ball(2), goal(1)-obj.ball(1))*180/pi;
        end

        function [F] = f_calculation(obj, lambda_1, F_in)
            theta = atan2(obj.ball(4), obj.ball(3));
            f_x = obj.m*obj.g*obj.mu*cos(theta);
            f_y = obj.m*obj.g*obj.mu*sin(theta);
            f_1_x = F_in*cosd(lambda_1);
            f_1_y = F_in*sind(lambda_1);
            F = [f_1_x - f_x, f_1_y - f_y];
        end

        function [a] = a_calculation(obj, F)
            a(1) = F(1)/obj.m;
            a(2) = F(2)/obj.m;
        end
        
        function new_ball = ball_controller(obj, a)
            new_ball(1) = obj.ball(1) + obj.ball(3)*obj.dt;
            new_ball(2) = obj.ball(2) + obj.ball(4)*obj.dt;
            new_ball(3) = obj.ball(3) + a(1)*obj.dt;
            new_ball(4) = obj.ball(4) + a(2)*obj.dt;
        end

        function collision = ball_collision(obj, new_ball)
            collision = 0;
            tem = 2;
            for i = 1: 1: 8
                dis = sqrt((new_ball(1)-obj.robotpos(i,1))^2+(new_ball(2)-obj.robotpos(i,2))^2);
                if i == obj.flag
                    dis = 10;
                end
                if dis < tem
                    tem = dis;
                    collision = i;
                end
            end
        end

        function [new_ball,targetpos] = back(obj)
            new_ball = obj.ball;
            targetpos(1) = 550;
            targetpos(2) = randi([200, 400]);
        end
    end
end

    