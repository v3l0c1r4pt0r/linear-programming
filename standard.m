function [A,b,c]=standard(F,A,b,Aeq,beq)
    c=F';
    if ~size(beq)
        return;
    end
    for i = 1:size(beq)
        newA = Aeq(i,:);
        A = [A; newA; -newA];
        b = [b; beq(i); -beq(i)];
    end
end