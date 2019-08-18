function out = realValue_crossover(parent)

sigma = -1+(1-(-1))*rand(1,1);    %龟计ユ皌璶ノ繦诀

for i=1:2:7
    out(i) = parent(i) + sigma*(parent(i)-parent(i+1));    %龟计近絃猭ユ皌(1)
end

for j=2:2:8
    out(j) = parent(j) - sigma*(parent(j-1)-parent(j));    %龟计近絃猭ユ皌(2)
end

for k=1:8
    if out(k)>10
        out(k) = 10;
    elseif out(k)<-10           %ňゎ壁竤禬筁10┪-10禲иㄆ砞﹚阶办
        out(k) = -10;
    end
    
end