
%Hrinda, G. (2010, April). Snap-through instability patterns in truss structures. 
%In 51st AIAA/ASME/ASCE/AHS/ASC Structures, Structural Dynamics, and Materials Conference 18th AIAA/ASME/AHS Adaptive Structures Conference 12th (p. 2611).


global Ucp n_step Cpt Ipt_gdl
global U F Fint 
global nodes elements Aff  
global n_elem n_gdl  

%------------------------------------------------------------------------	
% nodes (x,y,z)
%------------------------------------------------------------------------	
%n_nodes = 55;
n_nodes = 53;

nodes(1,:)=[0 0 0];
nodes(2,:)=[0 0 0];
nodes(3,:)=[0 0 0];
nodes(4,:)=[0 0 0];
nodes(5,:)=[0 0 0];
nodes(6,:)=[0 0 0];
nodes(7,:)=[0 0 0];
nodes(8,:)=[0 0 0];
nodes(9,:)=[0 0 0];
nodes(10,:)=[0 0 0];

nodes(11,:)=[1771.18 -3.252808 880.4231];
nodes(12,:)=[1871.251 -3.252808 884.3985];
nodes(13,:)=[971.5135 -3.252808 507.106];
nodes(14,:)=[1044.49 -3.252808 575.695];
nodes(15,:)=[1122.676 -3.252808 638.2787];
nodes(16,:)=[1205.581 -3.252808 694.4627];
nodes(17,:)=[1292.682 -3.252808 743.8929];
nodes(18,:)=[1383.43 -3.252808 786.2576];
nodes(19,:)=[1477.252 -3.252808 821.29];
nodes(20,:)=[1573.558 -3.252808 848.7689];
nodes(21,:)=[1671.74 -3.252808 868.5215];
nodes(22,:)=[1971.321 -3.252808 880.4233];
nodes(23,:)=[2070.761 -3.252808 868.5219];
nodes(24,:)=[2168.943 -3.252808 848.7695];
nodes(25,:)=[2265.249 -3.252808 821.2906];
nodes(26,:)=[2359.072 -3.252808 786.2585];
nodes(27,:)=[2449.819 -3.252808 743.8937];
nodes(28,:)=[2536.921 -3.252808 694.4637];

nodes(29,:)=[0 0 0];

nodes(30,:)=[2619.826 -3.252808 638.2797];
nodes(31,:)=[2698.013 -3.252808 575.6961];
nodes(32,:)=[2770.989 -3.252808 507.1073];
nodes(33,:)=[1007.762 -3.252808 471.5151];
nodes(34,:)=[1077.783 -3.252808 537.3278];
nodes(35,:)=[1152.821 -3.252808 597.3912];
nodes(36,:)=[1232.388 -3.252808 651.3125];
nodes(37,:)=[1315.982 -3.252808 698.751];
nodes(38,:)=[1403.075 -3.252808 739.4104];
nodes(39,:)=[1493.119 -3.252808 773.0319];
nodes(40,:)=[1585.546 -3.252808 799.4041];
nodes(41,:)=[1679.775 -3.252808 818.3611];
nodes(42,:)=[1775.21 -3.252808 829.7834];
nodes(43,:)=[1871.251 -3.252808 833.5988];
nodes(44,:)=[1967.292 -3.252808 829.7834];
nodes(45,:)=[2062.727 -3.252808 818.361];
nodes(46,:)=[2156.955 -3.252808 799.4041];
nodes(47,:)=[2249.383 -3.252808 773.0317];
nodes(48,:)=[2339.426 -3.252808 739.4104];
nodes(49,:)=[2426.52 -3.252808 698.752];
nodes(50,:)=[2510.114 -3.252808 651.3124];
nodes(51,:)=[2589.68 -3.252808 597.3911];
nodes(52,:)=[2664.718 -3.252808 537.3276];
nodes(53,:)=[2734.756 -3.252808 471.501];
%nodes(54,:)=[1849.562 -3.252808 872.0649];
%nodes(55,:)=[1849.562 -11.25281 843.7473];
% 
%nodes=nodes/10;

%------------------------------------------------------------------------	
% strut elements (nodes 1, nodes 2, k, LO)
% nodes1, nodes 2 = vertexes of the strut 
% LO = initial lenght of the strut
% k = axial stiffness of the strut 
%------------------------------------------------------------------------	
%n_elem = 103;
n_elem = 101;
A=25.4^2;
E=1E7*0.00689476;

% connectivity 

elements(1,1:2)=[11 12];
     
     
elements(2,1:2)=[13 14];
     
     
elements(3,1:2)=[14 15];
     
     
elements(4,1:2)=[15 16];
     
     
elements(5,1:2)=[16 17];
     
     
elements(6,1:2)=[17 18];
     
     
elements(7,1:2)=[18 19];
     
     
elements(8,1:2)=[19 20];
     
     
elements(9,1:2)=[20 21];
     
     
elements(10,1:2)=[21 11];
     
     
elements(11,1:2)=[12 22];
     
     
elements(12,1:2)=[22 23];
     
     
elements(13,1:2)=[23 24];
     
     
elements(14,1:2)=[24 25];
     
     
elements(15,1:2)=[25 26];
     
     
elements(16,1:2)=[26 27];
     
     
elements(17,1:2)=[30 31];
     
     
elements(18,1:2)=[31 32];
     
     
elements(19,1:2)=[33 34];
     
     
elements(20,1:2)=[34 35];
     
     
elements(21,1:2)=[35 36];
     
     
elements(22,1:2)=[36 37];
     
     
elements(23,1:2)=[37 38];
     
     
elements(24,1:2)=[38 39];
     
     
elements(25,1:2)=[39 40];
     
     
elements(26,1:2)=[40 41];
     
     
elements(27,1:2)=[41 42];
     
     
elements(28,1:2)=[42 43];
     
     
elements(29,1:2)=[43 44];
     
     
elements(30,1:2)=[44 45];
     
     
elements(31,1:2)=[45 46];
     
     
elements(32,1:2)=[46 47];
     
     
elements(33,1:2)=[47 48];
     
     
elements(34,1:2)=[48 49];
     
     
elements(35,1:2)=[49 50];
     
     
elements(36,1:2)=[50 51];
     
     
elements(37,1:2)=[51 52];
     
     
elements(38,1:2)=[52 53];
     
     
elements(39,1:2)=[53 32];
     
     
elements(40,1:2)=[13 33];
     
     
elements(41,1:2)=[14 34];
     
     
elements(42,1:2)=[15 35];
     
     
elements(43,1:2)=[16 36];
     
     
elements(44,1:2)=[17 37];
     
     
elements(45,1:2)=[18 38];
     
     
elements(46,1:2)=[19 39];
     
     
elements(47,1:2)=[20 40];
     
     
elements(48,1:2)=[21 41];
     
     
elements(49,1:2)=[11 42];
     
     
elements(50,1:2)=[12 43];
     
     
elements(51,1:2)=[22 44];
     
     
elements(52,1:2)=[23 45];
     
     
elements(53,1:2)=[24 46];
     
     
elements(54,1:2)=[25 47];
     
     
elements(55,1:2)=[26 48];
     
     
elements(56,1:2)=[27 49];
     
     
elements(57,1:2)=[28 50];
     
     
elements(58,1:2)=[30 51];
     
     
elements(59,1:2)=[27 28];
     
     
elements(60,1:2)=[28 30];
     
     
elements(61,1:2)=[52 31];
     
     
elements(62,1:2)=[13 34];
     
     
elements(63,1:2)=[34 15];
     
     
elements(64,1:2)=[15 36];
     
     
elements(65,1:2)=[33 14];
     
     
elements(66,1:2)=[14 35];
     
     
elements(67,1:2)=[35 16];
     
     
elements(68,1:2)=[16 37];
     
     
elements(69,1:2)=[37 18];
     
     
elements(70,1:2)=[36 17];
     
     
elements(71,1:2)=[17 38];
     
     
elements(72,1:2)=[38 19];
     
     
elements(73,1:2)=[19 40];
     
     
elements(74,1:2)=[40 21];
     
     
elements(75,1:2)=[18 39];
     
     
elements(76,1:2)=[39 20];
     
     
elements(77,1:2)=[20 41];
     
     
elements(78,1:2)=[21 42];
     

elements(79,1:2)=[42 12];

     
elements(80,1:2)=[12 44];
     
     
elements(81,1:2)=[41 11];
     
     
elements(82,1:2)=[11 43]; % modified
     
     
elements(83,1:2)=[43 22];
     
     
elements(84,1:2)=[22 45];
     
     
elements(85,1:2)=[45 24];
     
     
elements(86,1:2)=[44 23];
     
     
elements(87,1:2)=[23 46];
     
     
elements(88,1:2)=[46 25];
     
     
elements(89,1:2)=[25 48];
     
     
elements(90,1:2)=[48 27];
     
     
elements(91,1:2)=[27 50];
     
     
elements(92,1:2)=[24 47];
     
     
elements(93,1:2)=[47 26];
     
     
elements(94,1:2)=[26 49];
     
     
elements(95,1:2)=[49 28];
     
     
elements(96,1:2)=[28 51];
     
     
elements(97,1:2)=[50 30];
     
     
elements(98,1:2)=[30 52];
     
     
elements(99,1:2)=[52 32];
     
     
elements(100,1:2)=[51 31];
     
     
elements(101,1:2)=[31 53];


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
r(1:10) = [1:10];
r(11) = 29;
r(12) = 33;
r(13) = 53;

%------------------------------------------------------------------------	
% Afference matricies linking the local degrees of freedom of each nodes to the global dof 
% the i-th row is associated to the i-th nodes 
% each row: dof_x; dof_y; dof_rot
%------------------------------------------------------------------------	
n_gdl = 0;
for i=1:n_nodes
    v=find(r==i);
    if (isempty(v)) 
        Aff(i,1:3)=[n_gdl+1,0,n_gdl+2];
        n_gdl=n_gdl+2;
    else        
        Aff(i,:)=[0,0,0];
    end
end

%------------------------------------------------------------------------	
% Load vector : 4 concentrated forces applied to the nodes 6,7,8,9 
% direction of the forces: y 
%------------------------------------------------------------------------	
F(n_gdl,1) = 0.0;
F(Aff(12,3)) = -1E6*4.45;

%------------------------------------------------------------------------	
% CONTROL POINT
%------------------------------------------------------------------------	
Cpt = 12;                        % id of the nodes


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
% nStep=100;   % number of steps 


DrawStructure(elements,nodes);

