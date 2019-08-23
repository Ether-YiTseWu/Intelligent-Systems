function out = EA_mutation(generation)

    choose = randi(10,1,1);
    generation(choose) = generation(choose) + rand(1)*20;
        
    if generation(choose) > 10
        generation(choose) = 10;
    elseif generation(choose) < -10
        generation(choose) = -10;
    end
    
    out = generation;

end