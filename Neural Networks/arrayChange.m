function out = arrayChange(source,interval,last)

temp = 1;
for i = 1:interval:last
    out(temp,:) = source(i:i+9);
    temp = temp + 1;
end           

end