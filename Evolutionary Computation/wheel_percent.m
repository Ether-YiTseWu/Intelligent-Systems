function out = wheel_percent(fitnessValue)

for i=1:10
    if i == 1
        out(i) = fitnessValue(i)/sum(fitnessValue);                               %根據初始世代算出的適應值，求出各數值的比率(binary code)  
    else            
        out(i) = fitnessValue(i)/sum(fitnessValue)+out(i-1);
    end
end                           

end