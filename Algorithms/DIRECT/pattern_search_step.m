% Hooke-Jeeves Pattern Search
if nCostFun == "mulNone"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1_Org(x,step,R,Tol_R,Tol_dir); % 
elseif nCostFun == "mulAll"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1_M100All(x,step,R,Tol_R,Tol_dir); % Cost Function 
elseif nCostFun == "mulDisp"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1_M100Disp(x,step,R,Tol_R,Tol_dir); % Cost Function
elseif nCostFun == "dome"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1_Dome(x,step,R,Tol_R,Tol_dir);     % Cost Function
end

NVar=nVariables;                        % No of variables
alpha=2;                       % Mesh Size divisor
del=0.5;                       % Mesh size
epsilon=1e-6;                  % Mesh Tolerence STOP
epsilon1=1e-6;                 % Function Tolerence STOP

x=zeros(1,NVar).*ones(3,NVar); % Initial x Matrix
%x=[2 -6].*ones(3,NVar)        % Non Zero initial value
k=1;                           % Iteration index
xb=x(k,:);                     % Initial Base Point

while k < 10000
    for j=1:NVar                  % No of variable Iteration
        for i=1:3
            if i==2
                x(i,j)=x(i,j)+del; % Check x in +ve direction and store
                y(1,j)=x(i,j);     % function evaluation
            elseif i==3
                x(i,j)=x(i,j)-del; % Check x in -ve direction
                y(1,j)=x(i,j);
            else
                x(i,:)=x(i,:);     % Check at x
                y(1,:)=x(i,:);
            end
            %****************************Objective function***************************
            f1(i) = CostFunction(y);
            %f1(i) = fcn_test(y);
            %f1(i)=ps_example(y);   % Matlab function
            %*************************************************************************
            if i==1 & j==1 & k==1
                fmint(k)=f1(i);              % Initial f1 at k=1
            end
        end
        fmin(j)=min(f1);                 % Min of f1
        n=find(f1==fmin(j));             % Index of Min f1
        x=ones(k+2,NVar).*x(n(1),:);     % x at min f1
        xfmin(k+1,:)=x(k+1,:);           % Storing for results printing
        fmint(k+1)= min(fmin);           % min f1 for each var.
    end
    del1(k)=del;                       % Printing Mesh
    %*****************STOP WITH MESH & FUNCTION ERROR**************************
    delcheck=sqrt(del^2+del^2);
    if (delcheck < epsilon)  % Exit Iteration Check
        break
    end
    if abs(fmint(k+1))<epsilon1  % Exit Iteration Check
        break
    end
    %*********************EXPLORATORY TEST + Mesh Size*************************
    check2=x(1,:)~=xb(1,:);
    if any(check2)==1                    %Successful Polling
        xp(k+1,:)=x(k,:)+(x(k,:)-xb(1,:)); % Pattern Move point/Mesh Expansion
        xb(1,:)=x(k,:);                    % Store Base point
        x=xp(k+1,:);                       % Update base point
    elseif x(1,:)==xb(1,:)               %Unsuccessful Poll
        del=del/alpha;                     %Mesh contraction
    end
    %**********************Mesh contraction with Function**********************
    if fmint(k+1)==fmint(k)               %Unsucessful Poll
        del=del/alpha;                     %Mesh Contraction
    end
    %****************************Update x Matrix*******************************
    x=ones(k+2,NVar).*x;
    k=k+1;
end
%*****************************RESULTS*************************************
funmin=min(fmint)
d=find(funmin==fmint);
x=xfmin(d(end),:)
subplot(2,1,1),plot(fmint)
title('Objective function')
grid on
ylabel('Magnitude')
xlabel('Iteration')
subplot(2,1,2),plot(del1)
title('Mesh Size')
grid on
ylabel('Magnitude')
xlabel('Iteration')
