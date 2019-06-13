function out = RealAlphaCut (vector1,vector2)

for i=1:21
     for j=1:81
         temp1 = vector1(i);
         temp2 = vector2(j);
         out(i,j) = min(temp1,temp2);  %對應規則一，將x和y的每個輸入所得到的AlphaCut做取小運算，共得到21*81筆資料
     end
end

end