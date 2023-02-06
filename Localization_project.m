
clc
close all 
close all

% Drawing the Walls 
rectangle('Position',[0,0,6,15]);
rectangle('Position',[6,0,8,15]);
rectangle('Position',[14,0,8,8]);
rectangle('Position',[14,8,8,7]);
rectangle('Position',[22,0,3,15]);
rectangle('Position',[25,0,2,15]);
rectangle('Position',[27,0,3,15]);
rectangle('Position',[30,0,8,8]);
rectangle('Position',[30,8,8,7]);
rectangle('Position',[38,0,8,15]);
rectangle('Position',[46,0,6,15]);
rectangle('Position',[0,15,2,5]);
rectangle('Position',[2,16.5,4,3.5]);
rectangle('Position',[6,16.5,4,3.5]);
rectangle('Position',[10,16.5,4,3.5]);
rectangle('Position',[14,16.5,4,3.5]);
rectangle('Position',[18,16.5,4,3.5]);
rectangle('Position',[22,16.5,4,3.5]);
rectangle('Position',[26,16.5,4,3.5]);
rectangle('Position',[30,16.5,4,3.5]);
rectangle('Position',[34,16.5,4,3.5]);
rectangle('Position',[38,16.5,4,3.5]);
rectangle('Position',[42,16.5,4,3.5]);

%Drawing the APs
hold on 
plot(6,15.5635,'o')
plot(17.5,4,'o')
plot(25.5,15.5635,'o')
plot(33.4,4,'o')
plot(45,15.5625,'o')


% Getting the Xs and the Ys of the APIs 
x_APs = [6,17.5,25.5,33.5,45];
y_APs = [15.5625,4,15.5625,4,15.5625];

%Getting the X & Y values of all walls 
x_walls = [0 52;6 6;14 14;14 22;22 22;25 25;27 27;30 30;30 38;38 38;46 46;2 2;2 46;6 6;10 10;14 14;18 18;22 22;26 26;30 30;34 34;38 38;42 42;46 46];
y_walls = [15 15;0 15;0 15;15 15;0 15;0 15;0 15;0 15;15 15;0 15;0 15;15 20;16.5 16.5;16.5 20;16.5 20;16.5 20;16.5 20;16.5 20;16.5 20;16.5 20;16.5 20;16.5 20;16.5 20;16.5 20];

%Received power Array (each row represent a received power from 5 APs) 
Total_Power = [];

%Mapped points to received power array (each row represent a point)
Mapped_points = [];



%Loading the arrays
for x1 = 1:0.5:52
    for y1 = 1:0.5:20

        %for current point
        Total_Power_Temp = [];

        %looping on access points
        for i = 1:1:5
            x_AP = x_APs(i);
            y_AP = y_APs(i);
            Distance = sqrt( (x1- x_APs(i))^2 + (y1-y_APs(i))^2 );
            P_Loss = ( (4*pi*Distance)/0.125 )^3;
            P_Loss_DB = 10*log10(P_Loss);
            x_abs = [x1 x_AP];
            y_abs = [y1 y_AP];

            counter = 0;
            
            %looping on walls
            for w = 1:1:24
                x_wall = x_walls(w,:);
                y_wall = y_walls(w,:);
                [x_int,y_int] = curveintersect(x_wall,y_wall,x_abs,y_abs);
                if  isempty(x_int) == 0 && isempty(y_int) == 0
                    counter = counter + 1;
                end
            end
            
            %power received 
            Pr = -10 - P_Loss_DB - (3*counter);
            Total_Power_Temp(end+1) = Pr ;

        end
        Total_Power = [Total_Power;Total_Power_Temp];
        Mapped_points = [Mapped_points;x1 y1];

    end
end


[x,y] = Finding_Location(-80,-300,-300,-300,-300,Total_Power,Mapped_points);
x 
y
plot(x,y,'x','Color','Red')

%Contour Maps for each AP
for i=1:1:5
        D = [Mapped_points(:,1),Mapped_points(:,2),Total_Power(:,i)];
        [Du ,D1] = unique(D(:,1));
        Dd = diff(D1);
        Dr = reshape(D, Dd(1), [], size(D,2));
        X = Dr(:,:,1);
        Y = Dr(:,:,2);
        Z = Dr(:,:,3);
        figure
        contourf(X, Y, Z)
end

%Contour Map for all the AP
 Dtot = [Mapped_points(:,1),Mapped_points(:,2),max(Total_Power.').'];
        [Du,D1] = unique(Dtot(:,1));
        Dd = diff(D1);
        Dr = reshape(Dtot, Dd(1), [], size(Dtot,2));
        X = Dr(:,:,1);
        Y = Dr(:,:,2);
        Z = Dr(:,:,3);
        figure
        contourf(X, Y, Z)










    













