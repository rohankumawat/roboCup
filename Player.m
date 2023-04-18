classdef Player <handle

    %% PROPERTIES
    % Public (user-visible) properties
    properties
        headPosition = [0 0];
        robotDirection = [0 0];
        bodyPositionX = 0;
        bodyPositionY = 0;
        Accelaration = [0 0];
        Velocity = [0 0];
        Role; %R = striker
        Team = 1; %1 =left side,-1=right side
        headHandle = 0;
        bodyHandle = 0;
        headingAngle = 0;
        V_total = 0;
    end     
    methods
        function [x,y] = adjustDirection(obj)
            if (obj.Velocity(1) == 0) && (obj.Velocity(2)==0)
               x = linspace(obj.headPosition(1),obj.headPosition(1)+obj.Team*25);
               y = linspace(obj.headPosition(2),obj.headPosition(2));
            else 
            r = sqrt(obj.Velocity(1)^2+obj.Velocity(2)^2);
            x = linspace(obj.headPosition(1),obj.headPosition(1)+obj.Velocity(1)/r*25);
            y = linspace(obj.headPosition(2),obj.headPosition(2)+obj.Velocity(2)/r*25);
            end
        end

        function obj=setVelocity(obj,velocity)
            obj.Velocity = velocity;
            [x,y]=obj.adjustDirection;
            obj.bodyPositionX = x;
            obj.bodyPositionY = y;
        end
        
        function matrix = returnMatrix(obj)
               matrix = [obj.headPosition,obj.Velocity,obj.headingAngle,obj.V_total];
        end
    end
end