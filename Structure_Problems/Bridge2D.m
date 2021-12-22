

%Hrinda, G. (2010, April). Snap-through instability patterns in truss structures. 
%In 51st AIAA/ASME/ASCE/AHS/ASC Structures, Structural Dynamics, and Materials Conference 18th AIAA/ASME/AHS Adaptive Structures Conference 12th (p. 2611).


global Ucp n_step Cpt Ipt_gdl
global U F Fint 
global nodes elements Aff  
global n_elem n_gdl  

%------------------------------------------------------------------------	
% nodes (x,y,z)
%------------------------------------------------------------------------	
nodes=load('nodesBridge2D.txt');
n_nodes =size(nodes,1);

%------------------------------------------------------------------------	
% strut elements (nodes 1, nodes 2, k, LO)
% nodes1, nodes 2 = vertexes of the strut 
% LO = initial lenght of the strut
% k = axial stiffness of the strut 
%------------------------------------------------------------------------	
Connettivity=load('connettivityBridge2D.txt');
n_elem=size(Connettivity,1);

Forces=load('LoadsBridge2D.txt');

elements(:,1:2)=Connettivity(:,2:3);

% initial lenght 
for i=1:n_elem 
    
	Idxn1=find(nodes(:,1)==elements(i,1));
	Idxn2=find(nodes(:,1)==elements(i,2));
	
	n1=nodes(Idxn1,2:4);
    n2=nodes(Idxn2,2:4);

    elements(i,4) = ((n2(1) - n1(1))^2+(n2(2) - n1(2))^2+(n2(3) - n1(3))^2)^0.5; 
end 

E=203893.6;

% stiffness 
for i=1:n_elem 
    elements(i,3)=E*Connettivity(i,4)/elements(i,4);
end 

%------------------------------------------------------------------------	
% Structural Restraints 
% each component of this vector contains the id of the nodes which is
% considered fully restrained
%------------------------------------------------------------------------	
r(1)=	16;
r(2)=	24;
r(3)=	55;
r(4)=	47;
%------------------------------------------------------------------------	
% Afference matricies linking the local degrees of freedom of each nodes to the global dof 
% the i-th row is associated to the i-th nodes 
% each row: dof_x; dof_y; dof_rot
%------------------------------------------------------------------------	
n_gdl = 0;
for i=1:n_nodes

    if (nodes(i,1)==16 || nodes(i,1)==47) 
        Aff(i,1:3)=[0,0,0];
    elseif (nodes(i,1)==24 || nodes(i,1)==55)
        Aff(i,1:3)=[n_gdl+1,0,0];
        n_gdl=n_gdl+1;
    else        
        Aff(i,1:3)=[n_gdl+1,0,n_gdl+2];
        n_gdl=n_gdl+2;
    end
end

%------------------------------------------------------------------------	
% Load vector : 4 concentrated forces applied to the nodes 6,7,8,9 
% direction of the forces: y 
%------------------------------------------------------------------------	
F(n_gdl) = 0;
for i=1:length(Forces)
    idx=find(nodes(:,1)==Forces(i));
    F(Aff(idx,3))=-355.86*1000;
end

%------------------------------------------------------------------------	
% CONTROL POINT
%------------------------------------------------------------------------	
Cpt = 15;                        % id of the nodes

%------------------------------------------------------------------------	
% ANALYSIS SETTINGS
%------------------------------------------------------------------------	

% step radius
R=3;

% Tollerances  
Tol_dW=0.001;  % considered to check the object function 2
Tol_R=0.01;    % considered to check the constrain A1
Tol_dir=0.01;  % considered to check the constrain A2

% analysis seting  
step=1;   % number of steps 
nStep=100;   % number of steps 


%%DrawStructureDome(elements,nodes);




