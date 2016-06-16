%% Perform pivot operation, exchanging l-row with e-column variable
function [N,B,A,b,c,v]=pivot(N, B, A, b, c, v, l, e)
    %% Compute the coefficients of the equation for new basic variable x_e.
    m = size(A,1);
    n = size(A,2);
    Ad = zeros(m,n);                        % 2. a^ -> Ad
    li = find(B==l,1);                      % row of leaving var
    b(li) = b(li)/A(li,e);                  % 3.
    j = [N(N~=e) B];                        % 4.
    Ad(li,j) = A(li,j)/A(li,e);             % 5.
    Ad(li,e) = 1/A(li,e);                   % 6. divisor for leaving equation
    %% Compute the coefficients of the remaining constraints.
    i = find(B~=l);                         % 8.
    if ~isempty(i)
        b(i) = b(i) - A(i,e)*b(li);         % 9.
                                            % 10. already in j
        Ad(i,j) = A(i,j) - A(i,e)*Ad(li,j);	% 11.
        Ad(i,e) = -A(i,e)*Ad(li,e);         % 12.
    end
    %% Compute permament values of entering column elements
    Ad(li,e) = A(li,e)*Ad(li,e);
    Ad(i,e) = A(i,e) - A(i,e)*Ad(li,e);
    %% Compute the objective function
    v = v + c(e)*b(li);                     % 14.
                                            % 15. j again already set
    c(j) = c(j) - c(e) * Ad(li,j);          % 16.
    c(e) = c(e) -c(e) * Ad(li,e);           % 17.
    %% Compute new sets of basic and nonbasic variables.
    N(find(N==e,1)) = l;                    % 19.
    B(find(B==l,1)) = e;                    % 20.
    %% Return tuple
    A=Ad;                                   % 21.
end
