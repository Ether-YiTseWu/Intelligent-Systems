function out = RealAlphaCut (vector1,vector2)

for i=1:21
     for j=1:81
         temp1 = vector1(i);
         temp2 = vector2(j);
         out(i,j) = min(temp1,temp2);  %�����W�h�@�A�Nx�My���C�ӿ�J�ұo�쪺AlphaCut�����p�B��A�@�o��21*81�����
     end
end

end