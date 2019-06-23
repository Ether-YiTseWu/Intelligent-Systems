function out = R_mutation(generation)

    choose = randi(10,1,1);
    noise = -1+(1-(-1))*rand(1,1);
    generation(choose) = generation(choose) + noise*20;
        
    if generation(choose) > 10
        generation(choose) = 10;
    elseif generation(choose) < -10         %以防mutation後的人口，大過題目論域所做的補救措施
        generation(choose) = -10;
    end
    
    out = generation;

end