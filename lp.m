function [x,v,iters]=lp(F, A, b, Aeq, beq)
    %% Initialize
    m = size(A,1);
    n = size(A,2);
    %% Get standard form of linear problem
    [A,b,c] = standard(-F,A,b,Aeq,beq); % minus for minimum
    try
    [x,v,iters]=simplex(A, b, c);
    catch ME
        if size(ME.identifier) == 0
            fprintf('%s\n',ME.message);
            x=[];
            v=Inf;
            iters=-1;
        else
            rethrow(ME);
        end
    end
    v=-v;

end
