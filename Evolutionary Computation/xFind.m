function out = xFind(generation)

    temp = findFitness(generation);     %��A����

    for i = 1:10
        if power( (-15*power(sin(2*generation(i)),2)-power((generation(i)-2),2)+160) ,8) == max(temp)
            out = i;                    %�N��b��generation�̤j�A���Ȫ��H�f��index�D�X
        end
    end
end