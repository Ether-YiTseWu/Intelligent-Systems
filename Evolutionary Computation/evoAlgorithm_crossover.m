function out = evoAlgorithm_crossover(parent)

EA_R = -1+(1-(-1))*rand(1,1);               %EA型交配要用到的隨機值

for i=1:2:7
    out(i) = EA_R*parent(i) + (1-EA_R)*parent(i+1);
end

for j=2:2:8
    out(j) = EA_R*parent(j) + (1-EA_R)*parent(j-1);
end

for k=1:8
    if out(k)>10
        out(k) = 10;
    elseif out(k)<-10
        out(k) = -10;
    end

end