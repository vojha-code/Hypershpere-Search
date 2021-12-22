
%Hrinda, G. (2010, April). Snap-through instability patterns in truss structures. 
%In 51st AIAA/ASME/ASCE/AHS/ASC Structures, Structural Dynamics, and Materials Conference 18th AIAA/ASME/AHS Adaptive Structures Conference 12th (p. 2611).


global Ucp n_step Cpt Ipt_gdl
global U F Fint 
global nodes elements Aff  
global n_elem n_gdl  

%------------------------------------------------------------------------	
% nodes (x,y,z)
%------------------------------------------------------------------------	
nodes=load('nodesDome.txt');
n_nodes =size(nodes,1);

%------------------------------------------------------------------------	
% strut elements (nodes 1, nodes 2, k, LO)
% nodes1, nodes 2 = vertexes of the strut 
% LO = initial lenght of the strut
% k = axial stiffness of the strut 
%------------------------------------------------------------------------	
Connettivity=load('connettivityDome.txt');
n_elem=size(Connettivity,1);

elements(:,1:2)=Connettivity(:,2:3);

% initial lenght 
for i=1:n_elem 
    
	Idxn1=find(nodes(:,1)==elements(i,1));
	Idxn2=find(nodes(:,1)==elements(i,2));
	
	n1=nodes(Idxn1,2:4);
    n2=nodes(Idxn2,2:4);

    elements(i,4) = ((n2(1) - n1(1))^2+(n2(2) - n1(2))^2+(n2(3) - n1(3))^2)^0.5; 
end 

E=200000;

% stiffness 
for i=1:n_elem 
    elements(i,3)=E*Connettivity(i,4)/elements(i,4);
end 

%------------------------------------------------------------------------	
% Structural Restraints 
% each component of this vector contains the id of the nodes which is
% considered fully restrained
%------------------------------------------------------------------------	
r(1)=	217;
r(2)=	155;
r(3)=	19;
r(4)=	179;
r(5)=	178;
r(6)=	177;
r(7)=	176;
r(8)=	174;
r(9)=	173;
r(10)=	172;
r(11)=	171;
r(12)=	86;
r(13)=	90;
r(14)=	112;
r(15)=	111;
r(16)=	110;
r(17)=	109;
r(18)=	108;
r(19)=	106;
r(20)=	105;
r(21)=	104;
r(22)=	103;
r(23)=	102;
r(24)=	101;
%------------------------------------------------------------------------	
% Afference matricies linking the local degrees of freedom of each nodes to the global dof 
% the i-th row is associated to the i-th nodes 
% each row: dof_x; dof_y; dof_rot
%------------------------------------------------------------------------	
n_gdl = 0;
for i=1:n_nodes
    v=find(r==nodes(i,1));
    if (isempty(v)) 
        Aff(i,1:3)=[n_gdl+1,n_gdl+2,n_gdl+3];
        n_gdl=n_gdl+3;
    else        
        Aff(i,:)=[0,0,0];
    end
end

%------------------------------------------------------------------------	
% Load vector : 4 concentrated forces applied to the nodes 6,7,8,9 
% direction of the forces: y 
%------------------------------------------------------------------------	
F(n_gdl) = 0;
for i=1:n_gdl/3
F(3*(i-1)+3) = -100.0;
end

%------------------------------------------------------------------------	
% CONTROL POINT
%------------------------------------------------------------------------	
Cpt = 220;                        % id of the nodes

Cpt = find(nodes(:,1)==Cpt);

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
step = 1;
nStep=100;   % number of steps 


%DrawStructureDome(elements,nodes);




