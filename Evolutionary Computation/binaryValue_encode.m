function out = binaryValue_encode(decodeGeneration,origindecodeGeneration)      %��ѽX�᪺�G���s�X�H�f(-10:20/1023:10)�ର1~1024���ƭ�

for i =1:10
    
    for j = 1:1024
        if origindecodeGeneration(j) == decodeGeneration(i)     %
            out (i) = j;
        end
    end
    
end

end