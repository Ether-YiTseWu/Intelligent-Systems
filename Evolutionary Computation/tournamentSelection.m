function out = tournamentSelection(InitialGeneration,times)     %times表一次要從族群選幾個來做競爭

for i=1:10
    max = 1;

    b = InitialGeneration(randperm( length(InitialGeneration) ));
    for j=1:times
        ans(j) = power( (-15*power(sin(2*b(j)),2)-power((b(j)-2),2)+160) ,2);     %求出適應值
        if ans(j)>max
            max = ans(j);
            index = j;
        end
    end
    out(i) = b(index);
end

end