function out = realValue_crossover(parent)

sigma = -1+(1-(-1))*rand(1,1);    %��ƫ���t�n�Ψ쪺�H����

for i=1:2:7
    out(i) = parent(i) + sigma*(parent(i)-parent(i+1));    %��ƫ����L�k��t(1)
end

for j=2:2:8
    out(j) = parent(j) - sigma*(parent(j-1)-parent(j));    %��ƫ����L�k��t(2)
end

for k=1:8
    if out(k)>10
        out(k) = 10;
    elseif out(k)<-10           %����ڸs�W�L10�Τp��-10�A�]�X�ڭ̨ƥ��]�w���װ�F
        out(k) = -10;
    end
    
end