function out = rouletteWheelSelection(randInitialGeneration,proportion)

for i=1:10
    tempV = rand(1);                 %產出輪盤法所需用到的亂數
    
    if     0 < tempV              & tempV <= proportion(1)      %利用連續的條件判斷找出此比率所對應的人口是誰
        out(i) = randInitialGeneration(1);
        
    elseif proportion(1) < tempV  & tempV <= proportion(2)
        out(i) = randInitialGeneration(2);
        
	elseif proportion(2) < tempV  & tempV <= proportion(3)
        out(i) = randInitialGeneration(3);
        
	elseif proportion(3) < tempV  & tempV <= proportion(4)
        out(i) = randInitialGeneration(4);
        
    elseif proportion(4) < tempV  & tempV <= proportion(5)
        out(i) = randInitialGeneration(5);
        
    elseif proportion(5) < tempV  & tempV <= proportion(6)
        out(i) = randInitialGeneration(6);
        
    elseif proportion(6) < tempV  & tempV <= proportion(7)
        out(i) = randInitialGeneration(7);
        
    elseif proportion(7) < tempV  & tempV <= proportion(8)
        out(i) = randInitialGeneration(8);
        
    elseif proportion(8) < tempV  & tempV <= proportion(9)
        out(i) = randInitialGeneration(9);
        
    elseif proportion(9) < tempV  & tempV <= proportion(10)
        out(i) = randInitialGeneration(10);
    end
    
end