function out = xFind(generation)

    temp = findFitness(generation);     %算適應值

    for i = 1:10
        if power( (-15*power(sin(2*generation(i)),2)-power((generation(i)-2),2)+160) ,8) == max(temp)
            out = i;                    %將位在此generation最大適應值的人口之index求出
        end
    end
end