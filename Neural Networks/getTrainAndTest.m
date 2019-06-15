function out = getTrainAndTest(source,index,sampleNum,location)

for i=1:sampleNum
    out(i) = source(index(i),location);
end

end