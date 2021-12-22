clc;
clear all;
close all;
%% Loda Curves
curve_bridge =  load('curve_bridge.mat').Bridge;
curve_2dstar =  load('curve_star.mat').Star;
curve_2darch =  load('curve_arch.mat').Arch;
curve_3d8member =  load('curve_8member.mat').Eight;

%% PLot Curves
paperunits='inches';
figWidth = 5;
figHeight = 2;
size=[figWidth figHeight];

fig = figure(1);
plot (curve_3d8member(:,1),curve_3d8member(:,2),'LineWidth',2,'Color','r');
xlabel('displacement','FontSize',12) 
ylabel('load multiplier','FontSize',12) 
orient(fig,'landscape')
%set(fig,'paperunits',paperunits,'paperposition',[0 0 size]);
%set(fig, 'PaperSize', size);
print(fig, 'curve_8member.pdf', '-dpdf', '-fillpage')


fig = figure(2);
plot (curve_2dstar(:,1),curve_2dstar(:,2),'LineWidth',2,'Color','b');
xlabel('displacement','FontSize',12) 
ylabel('load multiplier','FontSize',12) 
orient(fig,'landscape')
%set(fig,'paperunits',paperunits,'paperposition',[0 0 size]);
%set(fig, 'PaperSize', size);
print(fig, 'curve_star.pdf', '-dpdf', '-fillpage')

fig = figure(3);
plot (curve_bridge(:,1),curve_bridge(:,2),'LineWidth',2,'Color','k');
xlabel('displacement','FontSize',12) 
ylabel('load multiplier','FontSize',12) 
orient(fig,'landscape')
%set(fig,'paperunits',paperunits,'paperposition',[0 0 size]);
%set(fig, 'PaperSize', size);
print(fig, 'curve_bridge.pdf', '-dpdf', '-fillpage')


fig = figure(4);
plot (curve_2darch(:,1),curve_2darch(:,2),'LineWidth',2,'Color','r');
xlabel('displacement','FontSize',12) 
ylabel('load multiplier','FontSize',12) 
orient(fig,'landscape')
%set(fig,'paperunits',paperunits,'paperposition',[0 0 size]);
%set(fig, 'PaperSize', size);
print(fig, 'curve_arch.pdf', '-dpdf', '-fillpage')




