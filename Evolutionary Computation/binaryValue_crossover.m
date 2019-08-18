function out = binaryValue_crossover(parent)

    out = parent;
    onePoint = randi(5,1,1);
    onePoint_plus = randi(4,1,1);
    
for i=1:2:7
    jj = 0;                                          %每次迴圈進行初始化以便後面計算的值不會有誤差
    index = 0;
    
    for j = onePoint:onePoint+onePoint_plus          %使用兩點交配進行計算
        if out(i,j) ~= out(i+1,j)
            jj = jj+1;
            index(jj) = j;                           %使用index矩陣紀錄需要進行位元交換的地方
        end
    end
    
    if index(1) ~= 0                                 %確認要進行交配的兩個人口長得不一樣，才開始進行計算
        for k = 1:length(index)                      
            temp = out(i,index(k));
            out(i,index(k)) = out(i+1,index(k));
            out(i+1,index(k)) = temp;                %swap
        end
    end
        
end

end