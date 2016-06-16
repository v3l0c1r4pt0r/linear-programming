%% Convert standard form of (A,b,c) into slack form
function [N,B,A,b,c,v]=slack(A,b,c)
    %% Initialize
    m = size(A,1);
    n = size(A,2);
    %% Create slack form
    N = 1:n;
    B = n+1:n+m;
    c = [c zeros(1,m)];
    A = [A eye(m)];
    v = 0;
end