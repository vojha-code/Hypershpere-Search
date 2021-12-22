
%Hrinda, G. (2010, April). Snap-through instability patterns in truss structures. 
%In 51st AIAA/ASME/ASCE/AHS/ASC Structures, Structural Dynamics, and Materials Conference 18th AIAA/ASME/AHS Adaptive Structures Conference 12th (p. 2611).


global Ucp n_step Cpt Ipt_gdl
global U F Fint 
global nodes elements Aff  
global n_elem n_gdl  

%------------------------------------------------------------------------	
% nodes (x,y,z)
%------------------------------------------------------------------------	
n_nodes = 9;

nodes(1,:)=[  0 0 101.6    ];

nodes(2,:)=[  127 -127  50.8    ];
nodes(3,:)=[  127  127  50.8	];
nodes(4,:)=[ -127  127   50.8	];
nodes(5,:)=[ -127 -127   50.8	];

nodes(6,:)=[ 254 0   0.00	];
nodes(7,:)=[ 0 254   0.00	];
nodes(8,:)=[ -254 0   0.00	];
nodes(9,:)=[ 0 -254   0.00	];


%------------------------------------------------------------------------	
% strut elements (nodes 1, nodes 2, k, LO)
% nodes1, nodes 2 = vertexes of the strut 
% LO = initial lenght of the strut
% k = axial stiffness of the strut 
%------------------------------------------------------------------------	
n_elem = 16;
A=25.4^2;
E=1E7*0.00689476;

% connectivity 

elements(1,1:2) =[6 3];
elements(2,1:2) =[7 3];
elements(3,1:2) =[7 4];
elements(4,1:2) =[4 8];
elements(5,1:2) =[8 5];
elements(6,1:2) =[5 9];
elements(7,1:2) =[9 2];
elements(8,1:2) =[2 6];

elements(9,1:2) =[2 3];
elements(10,1:2) =[3 4];
elements(11,1:2) =[4 5];
elements(12,1:2) =[5 2];

elements(13,1:2) =[1 2];
elements(14,1:2) =[1 3];
elements(15,1:2) =[1 4];
elements(16,1:2) =[1 5];

% initial lenght 
for i=1:n_elem 
    n1=nodes(elements(i,1),:);
    n2=nodes(elements(i,2),:);

    elements(i,4) = ((n2(1) - n1(1))^2+(n2(2) - n1(2))^2+(n2(3) - n1(3))^2)^0.5; 
end 

% stiffness 
for i=1:n_elem 
    elements(i,3)=E*A/elements(i,4);
end 

%------------------------------------------------------------------------	
% Structural Restraints 
% each component of this vector contains the id of the nodes which is
% considered fully restrained
%------------------------------------------------------------------------	
r(1) = 6;
r(2) = 7;
r(3) = 8;
r(4) = 9;

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
F(3,1) = -1E6*4.45;

%------------------------------------------------------------------------	
% CONTROL POINT
%------------------------------------------------------------------------	
Cpt = 1;                        % id of the nodes


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
%nStep = 50;   % number of steps 


DrawStructure(elements,nodes);




