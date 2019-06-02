function out = Power_Ans (vector1,vector2)

s = 1;
for i=1:21                                                   
     for j=1:81                                   %vector(i、j)代表，從X軸共81個點及Y軸共21個點所得出的81*21個可能中，每個值所對應的Alphacut為多少，一個一個取出來以便與輸出函數做取小運算   
         for k=1:601                              %k代表功率輸出圖形中的601個點，隨著迴圈一點一點被取出來
             temp1 = vector1(i,j);
             temp2 = vector2(k);
             out(s,k) = min (temp1,temp2);
         end
         s = s+1;
     end
end

end