function out = binaryValue_crossover(parent)

    out = parent;
    onePoint = randi(5,1,1);
    onePoint_plus = randi(4,1,1);
    
for i=1:2:7
    jj = 0;                                          %�C���j��i���l�ƥH�K�᭱�p�⪺�Ȥ��|���~�t
    index = 0;
    
    for j = onePoint:onePoint+onePoint_plus          %�ϥΨ��I��t�i��p��
        if out(i,j) ~= out(i+1,j)
            jj = jj+1;
            index(jj) = j;                           %�ϥ�index�x�}�����ݭn�i��줸�洫���a��
        end
    end
    
    if index(1) ~= 0                                 %�T�{�n�i���t����ӤH�f���o���@�ˡA�~�}�l�i��p��
        for k = 1:length(index)                      
            temp = out(i,index(k));
            out(i,index(k)) = out(i+1,index(k));
            out(i+1,index(k)) = temp;                %swap
        end
    end
        
end

end