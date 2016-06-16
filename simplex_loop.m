%% Iterate through simplex algorithm main loop
function [N,B,A,b,c,v,iters]=simplex_loop(N, B, A, b, c, v)
    %% Initialization
    iters=0;
    m = size(A,1);
    n = size(A,2);
    while ~isempty(c(c(N)>0))                       % 3.
        e = N(find(c(N)>0,1));                      % 4.
        i = find(B);                                % 5.
        ip = i(A(i,e)>0);                           % 6.
        delta = ones(m,1)*Inf;                      % [2,8].
        if ~isempty(ip)
            delta(ip) = b(ip)./A(ip,e);             % 7.
        end
        [~,L] = min(delta);                         % 9. index in B
        l = B(L);                                   % 9. value of B @ L
        if delta(L) == Inf                          % 10.
            error(sprintf('unbounded(%d)',iters));  % 11.
        else
            [N,B,A,b,c,v] = pivot(N,B,A,b,c,v,l,e); % 12.
        end
        iters = iters + 1;
    end
end
