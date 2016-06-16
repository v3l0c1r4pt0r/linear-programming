function [N,B,A,b,c,v]=initialize_simplex(A,b,c)
    %% Initialize
    m = size(A,1);
    n = size(A,2);
    %% Is the initial basic solution feasible?
    [~,k] = min(b);                                         % 1.
    if b(k) >= 0                                            % 2.
        [N,B,A,b,c,v] = slack(A,b,c);                       % 3.
        return;                                             % 3.
    end
    %% form L_aux in its slack form
    Aaux = [A ones(m,1)*-1];                                % 4.
    caux = [zeros(1,n) -1];                                 % 4.
    [N,B,A,b,caux,v] = slack(Aaux,b,caux);                  % 5.
    l = n + k + 1;                                          % 6.
    % originally n+k, cause counting -x_0 as 0-th element,
    % not supported by MATLAB
    %% L_aux has n+1 nonbasic variables and m basic variables.
    [N,B,A,b,caux,v] = pivot(N,B,A,b,caux,v,l,n+1);         % 8.
    %% The basic solution is now feasible for L_aux.
    [N,B,A,b,caux,v,iters] = simplex_loop(N,B,A,b,caux,v);  % 10.
    if v ~= 0                                               % 11.
        error(sprintf('infeasible(%d)',iters));             % 16.
    end
    if ~isempty(find(B==(n+1),1))                           % 12.
        lr=A(find(B==n+1),:);
        lr(B)=0;
        e=find(lr~=0,1);
        [N,B,A,b,caux,v] = pivot(N,B,A,b,caux,v,n+1,e);     % 13.
    end
    A(:,n+1)=[];                                            % 14.
    N(N==n+1)=[];                                           % 14.
    N(N>n+1)=N(N>n+1)-1;                                    % 14.
    B(B>n+1)=B(B>n+1)-1;                                    % 14.
    c = [c zeros(1,m)];
    v = v + c(B)*b;                                         % 14.
    i=find(B);
    for j = N
        c(j) = c(j) - sum(c(B) * A(i,j));                   % 14.
    end
    c(B)=0;                                                 % 14.
    fprintf('init(%d)\n',iters);
end
