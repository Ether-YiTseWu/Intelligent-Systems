function out = findFitness(generation)       %�D�X�A���Ȫ������A�]���ӱ`�X�{�A�K�⥦�s����ơA�Y�n���ܾA����Ƥ]�వ�@���ʭק�F

    for i=1:10
        out(i) = power( (-15*power(sin(2*generation(i)),2)-power((generation(i)-2),2)+160) ,8);
    end

end