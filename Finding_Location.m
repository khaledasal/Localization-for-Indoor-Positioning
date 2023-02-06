function [x,y] = Finding_Location(R1,R2,R3,R4,R5,Total_Power,Mapped_points)

Total_Received = [];

for i = 1:1:1040
    Total_Power_Temp = Total_Power(i,:);
    Received_Temp =(R1-Total_Power_Temp(1))^2 + (R2-Total_Power_Temp(2))^2 + (R3-Total_Power_Temp(3))^2 + (R4-Total_Power_Temp(4))^2 + (R5-Total_Power_Temp(5))^2;
    Total_Received(end+1) = Received_Temp;
end

Min_Power_index = find(Total_Received == min(Total_Received));

x = Mapped_points(Min_Power_index,1);
y = Mapped_points(Min_Power_index,2);

end