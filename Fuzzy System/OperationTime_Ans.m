function out = OperationTime_Ans (vector1,vector2)

s = 1;
for i=1:21                                                  
     for j=1:81
         for k=1:11                                        
             temp1 = vector1(i,j);
             temp2 = vector2(k);            
             out(s,k) = min (temp1,temp2);
         end
         s = s+1;
     end
end

end