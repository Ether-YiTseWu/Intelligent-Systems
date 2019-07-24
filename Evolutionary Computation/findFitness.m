function out = findFitness(generation)       %求出適應值的公式，因為太常出現，便把它編成函數，若要改變適應函數也能做一次性修改了

    for i=1:10
        out(i) = power( (-15*power(sin(2*generation(i)),2)-power((generation(i)-2),2)+160) ,8);
    end

end