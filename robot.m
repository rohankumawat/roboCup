classdef robot <handle
    properties
        robot_1 = [10, 10, 0, 0, 90, 0];
        dot_vf = 0;
        dot_lambda = 0;
        goal = [2, 2];
        dt = 0.05;
        kp = 15;
        kd = 0.5;
        result = [];
    end

    methods

        function update(obj, robot_1, dot_vf, dot_lambda, goal)
            obj.robot_1 = robot_1;
            obj.dot_vf = dot_vf;
            obj.dot_lambda = dot_lambda;
            obj.goal = goal;
        end

        function [dot_vf, dot_lambda, robot_1] = robot_control(obj)
            last_state = obj.robot_1;
            last_goal = obj.goal;
            robot_1 = obj.state_space_form();
            [e_lambda, e_p] = obj.error_renew(robot_1);
            a = obj.pd_controller( last_state(1), robot_1(1), last_goal(1), obj.goal(1), e_p);
            v_lambda = obj.pd_controller(last_state(5), robot_1(5), last_goal(2), obj.goal(2), e_lambda);
            [dot_vf, dot_lambda] = obj.renew_part(a, v_lambda);
        end
        
        function [e_lambda, e_p] = error_renew(obj, state)
            e_p = abs(obj.goal(1) - state(1)) - 0.8;
            e_lambda = atan2((obj.goal(2) - state(2)), (obj.goal(1) - state(1)))*180 / pi - state(5);
            obj.result = [obj.result;obj.goal,state];
        
        end
        
        function [out] = pd_controller(obj, last_state, now_state, last_goal, now_goal, e_state)
            d_state = now_state - last_state;
            d_goal = now_goal - last_goal;
            out = obj.kp * e_state + obj.kd * (d_goal/obj.dt - d_state/obj.dt);
        end
        
        function new_state = state_space_form(obj)
        
            u = [obj.dot_vf , obj.dot_lambda];
            x1_dot = obj.robot_1(3);
            x2_dot = obj.robot_1(4);
            x3_dot = u(1) * cosd(obj.robot_1(5));
            x4_dot = u(1) * sind(obj.robot_1(5));
            x5_dot = u(2);
            x6_dot = u(1);
            
            x_dot = [x1_dot, x2_dot, x3_dot, x4_dot, x5_dot, x6_dot];
            new_state = obj.robot_1 + x_dot * obj.dt;
            new_state(6) = max(0, new_state(6));
            new_state(6) = min(7, new_state(6));
            new_state(3) = new_state(6) * cosd(new_state(5));
            new_state(4) = new_state(6) * sind(new_state(5));
            new_state(1) = obj.robot_1(1) + new_state(3);
            new_state(2) = obj.robot_1(2) + new_state(4);
            
        end
        
        function [new_a, new_lambda] = renew_part(obj, a, v_lambda)
            new_a = obj.dot_vf + a;
            new_a = min(0.8, new_a);
            new_lambda = v_lambda;
        end
    end
end