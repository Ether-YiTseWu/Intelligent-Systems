function out = tournamentSelection(InitialGeneration,times)     %times��@���n�q�ڸs��X�ӨӰ��v��

for i=1:10
    max = 1;

    b = InitialGeneration(randperm( length(InitialGeneration) ));
    for j=1:times
        ans(j) = power( (-15*power(sin(2*b(j)),2)-power((b(j)-2),2)+160) ,2);     %�D�X�A����
        if ans(j)>max
            max = ans(j);
            index = j;
        end
    end
    out(i) = b(index);
end

end