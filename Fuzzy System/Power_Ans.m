function out = Power_Ans (vector1,vector2)

s = 1;
for i=1:21                                                   
     for j=1:81                                   %vector(i�Bj)�N��A�qX�b�@81���I��Y�b�@21���I�ұo�X��81*21�ӥi�त�A�C�ӭȩҹ�����Alphacut���h�֡A�@�Ӥ@�Ө��X�ӥH�K�P��X��ư����p�B��   
         for k=1:601                              %k�N��\�v��X�ϧΤ���601���I�A�H�۰j��@�I�@�I�Q���X��
             temp1 = vector1(i,j);
             temp2 = vector2(k);
             out(s,k) = min (temp1,temp2);
         end
         s = s+1;
     end
end

end