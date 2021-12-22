
% 3D Reticular Beam Example

global Ucp n_step Cpt Ipt_gdl
global U F Fint 
global nodes elements Aff  
global n_elem n_gdl  

%------------------------------------------------------------------------	
% nodes (x,y,z)
%------------------------------------------------------------------------	
%{
OLD nodes
n_nodes = 14;

nodes(1+0,0+1) = 0;          nodes(1+0,1+1) = 0; 		nodes(1+0,2+1) = 0;
nodes(1+1,0+1) = 2000; 		nodes(1+1,1+1) = 0; 		nodes(1+1,2+1) = 0;
nodes(1+2,0+1) = 4000; 		nodes(1+2,1+1) = 0; 		nodes(1+2,2+1) = 0;
nodes(1+3,0+1) = 6000; 		nodes(1+3,1+1) = 0; 		nodes(1+3,2+1) = 0;
nodes(1+4,0+1) = 8000; 		nodes(1+4,1+1) = 0; 		nodes(1+4,2+1) = 0;
nodes(1+5,0+1) = 1000; 		nodes(1+5,1+1) = 1000; 	nodes(1+5,2+1) = 2000;
nodes(1+6,0+1) = 3000; 		nodes(1+6,1+1) = 1000; 	nodes(1+6,2+1) = 2000;
nodes(1+7,0+1) = 5000; 		nodes(1+7,1+1) = 1000; 	nodes(1+7,2+1) = 2000;
nodes(1+8,0+1) = 7000; 		nodes(1+8,1+1) = 1000; 	nodes(1+8,2+1) = 2000;
nodes(1+9,0+1) = 0;          nodes(1+9,1+1) = 2000; 	nodes(1+9,2+1) = 0;
nodes(1+10,0+1) = 2000;      nodes(1+10,1+1) = 2000; 	nodes(1+10,2+1) = 0;
nodes(1+11,0+1) = 4000;      nodes(1+11,1+1) = 2000; 	nodes(1+11,2+1) = 0;
nodes(1+12,0+1) = 6000;      nodes(1+12,1+1) = 2000; 	nodes(1+12,2+1) = 0;
nodes(1+13,0+1) = 8000; 	 nodes(1+13,1+1) = 2000; 	nodes(1+13,2+1) = 0;     
%}

%------------------------------------------------------------------------	
% NEW Nodes
% nodes (x,y,z)
%------------------------------------------------------------------------	
n_nodes = 14;

nodes(1+0,0+1) = 0;          nodes(1+0,1+1) = 0; 		nodes(1+0,2+1) = 0;
nodes(1+1,0+1) = 2000; 		nodes(1+1,1+1) = 0; 		nodes(1+1,2+1) = 0;
nodes(1+2,0+1) = 4000; 		nodes(1+2,1+1) = 0; 		nodes(1+2,2+1) = 0;
nodes(1+3,0+1) = 6000; 		nodes(1+3,1+1) = 0; 		nodes(1+3,2+1) = 0;
nodes(1+4,0+1) = 8000; 		nodes(1+4,1+1) = 0; 		nodes(1+4,2+1) = 0;
nodes(1+5,0+1) = 1000; 		nodes(1+5,1+1) = 1000; 	    nodes(1+5,2+1) = 800;
nodes(1+6,0+1) = 3000; 		nodes(1+6,1+1) = 1000; 	    nodes(1+6,2+1) = 800;
nodes(1+7,0+1) = 5000; 		nodes(1+7,1+1) = 1000; 	    nodes(1+7,2+1) = 800;
nodes(1+8,0+1) = 7000; 		nodes(1+8,1+1) = 1000; 	    nodes(1+8,2+1) = 800;
nodes(1+9,0+1) = 0;          nodes(1+9,1+1) = 2000; 	nodes(1+9,2+1) = 0;
nodes(1+10,0+1) = 2000;      nodes(1+10,1+1) = 2000; 	nodes(1+10,2+1) = 0;
nodes(1+11,0+1) = 4000;      nodes(1+11,1+1) = 2000; 	nodes(1+11,2+1) = 0;
nodes(1+12,0+1) = 6000;      nodes(1+12,1+1) = 2000; 	nodes(1+12,2+1) = 0;
nodes(1+13,0+1) = 8000; 	 nodes(1+13,1+1) = 2000; 	nodes(1+13,2+1) = 0;     
%------------------------------------------------------------------------	
% strut elements (nodes 1, nodes 2, k, LO)
% nodes1, nodes 2 = vertexes of the strut 
% LO = initial lenght of the strut
% k = axial stiffness of the strut 
%------------------------------------------------------------------------	
n_elem = 40;
EA = 500000;        

% connectivity 
elements(1+0,1) = 1; elements(1+0,2) = 2;
elements(1+1,1) = 2; elements(1+1,2) = 3;
elements(1+2,1) = 3; elements(1+2,2) = 4;
elements(1+3,1) = 4; elements(1+3,2) = 5;
elements(1+4,1) = 10; elements(1+4,2) = 11;
elements(1+5,1) = 11; elements(1+5,2) = 12;
elements(1+6,1) = 12; elements(1+6,2) = 13;
elements(1+7,1) = 13; elements(1+7,2) = 14;
elements(1+8,1) = 1; elements(1+8,2) = 10;
elements(1+9,1) = 5; elements(1+9,2) = 14;
elements(1+10,1) = 1; elements(1+10,2) = 6;
elements(1+11,1) = 6; elements(1+11,2) = 2;
elements(1+12,1) = 2; elements(1+12,2) = 7;
elements(1+13,1) = 7; elements(1+13,2) = 3;
elements(1+14,1) = 3; elements(1+14,2) = 8;
elements(1+15,1) = 8; elements(1+15,2) = 4;
elements(1+16,1) = 4; elements(1+16,2) = 9;
elements(1+17,1) = 9; elements(1+17,2) = 5;
elements(1+18,1) = 10; elements(1+18,2) = 6;
elements(1+19,1) = 6; elements(1+19,2) = 11;
elements(1+20,1) = 11; elements(1+20,2) = 7;
elements(1+21,1) = 7; elements(1+21,2) = 12;
elements(1+22,1) = 12; elements(1+22,2) = 8;
elements(1+23,1) = 8; elements(1+23,2) = 13;
elements(1+24,1) = 13; elements(1+24,2) = 9;
elements(1+25,1) = 9; elements(1+25,2) = 14;
elements(1+26,1) = 6; elements(1+26,2) = 7;
elements(1+27,1) = 7; elements(1+27,2) = 8;
elements(1+28,1) = 8; elements(1+28,2) = 9;
elements(1+29,1) = 1; elements(1+29,2) = 11;
elements(1+30,1) = 11; elements(1+30,2) = 3;
elements(1+31,1) = 3; elements(1+31,2) = 13;
elements(1+32,1) = 13; elements(1+32,2) = 5;
elements(1+33,1) = 10; elements(1+33,2) = 2;
elements(1+34,1) = 2; elements(1+34,2) = 12;
elements(1+35,1) = 12; elements(1+35,2) = 4;
elements(1+36,1) = 4; elements(1+36,2) = 14;
elements(1+37,1) = 2; elements(1+37,2) = 11;
elements(1+38,1) = 3; elements(1+38,2) = 12;
elements(1+39,1) = 4; elements(1+39,2) = 13;

% initial lenght 
for i=1:n_elem 
    n1=nodes(elements(i,1),:);
    n2=nodes(elements(i,2),:);

    elements(i,4) = ((n2(1) - n1(1))^2+(n2(2) - n1(2))^2+(n2(3) - n1(3))^2)^0.5; 
end 

% stiffness 
for i=1:n_elem 
    elements(i,3)=EA/elements(i,4);
end 

%------------------------------------------------------------------------	
% Structural Restraints 
% each component of this vector contains the id of the nodes which is
% considered fully restrained
%------------------------------------------------------------------------	
r(1) = 1;
r(2) = 5;
r(3) = 10;
r(4) = 14;

%------------------------------------------------------------------------	
% Afference matricies linking the local degrees of freedom of each nodes to the global dof 
% the i-th row is associated to the i-th nodes 
% each row: dof_x; dof_y; dof_rot
%------------------------------------------------------------------------	
n_gdl = 0;
for i=1:n_nodes
    v=find(r==i);
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
F(n_gdl,1) = 0.0;
F(Aff(6,3)) = -100.0; %F(Aff(6,3)) = -100.0;
F(Aff(7,3)) = -100.0;
F(Aff(8,3)) = -100.0;
F(Aff(9,3)) = -100.0;

%------------------------------------------------------------------------	
% CONTROL POINT
%------------------------------------------------------------------------	
Cpt = 7;                        % id of the nodes


%------------------------------------------------------------------------	
% ANALYSIS SETTINGS
%------------------------------------------------------------------------	

% step radius
R = 10; % options:  2.77526, 5 and 10

% Tollerances  
Tol_dW=0.001;  % considered to check the object function 2
Tol_R=0.01;    % considered to check the constrain A1
Tol_dir=0.01;  % considered to check the constrain A2

DrawStructure(elements,nodes);
