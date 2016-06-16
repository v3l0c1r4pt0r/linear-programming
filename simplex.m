%% Compute minimal result of a linear programming task
function [x,v,iters]=simplex(A, b, c)
    %% Initialize
    m = size(A,1);
    n = size(A,2);
    %% Compute result
    [N,B,A,b,c,v]=initialize_simplex(A,b,c);        % 1.
    [N,B,A,b,c,v,iters]=simplex_loop(N,B,A,b,c,v);  % [2-12].
    x = zeros(1,n+m);                               % [13,16].
    x(B) = b;                                       % [14,15].
end