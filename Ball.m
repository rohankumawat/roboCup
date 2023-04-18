classdef Ball <handle

    %% PROPERTIES
    % Public (user-visible) properties
    properties
        Position = [0 0];
        Velocity = [0 0];
        Holder = 0;
        Handle = 0;
        LastHolder = 0;
    end     
    methods
        function matrix = returnMatrix(obj)
               matrix = [obj.Position,obj.Velocity];
        end

        function output = whetherOut(obj)
            if obj.Position(1)<100||obj.Position(1)>1000
                output=-1;
            elseif obj.Position(2)<50||obj.Position(2)>650
                output=1;
            else
                output=0;
            end
        end

        function output = whetherGoal(obj)
            if obj.Position(1)>=40 && obj.Position(1)<=100
                if obj.Position(2)<=480 && obj.Position(2)>=220
                    output = -1;
                else
                    output = 0;
                end
            elseif obj.Position(1)>=1000 && obj.Position(1)<=1060
                if obj.Position(2)<=480 && obj.Position(2)>=220
                    output = 1;
                else
                    output = 0;
                end
            else
                output =0;
            end
        end

        function output = ballHoler(obj)
            output=obj.Holder;
        end

    end
end