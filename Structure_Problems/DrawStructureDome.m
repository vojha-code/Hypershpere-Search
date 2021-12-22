function DrawStructureDome(elem,nodes)

    fig = figure(1);
    set(fig,'PaperSize',[3 3]);
    hold on; 
    az = 21;%21;%90;
    el = 0%;0;
    view(az, el);
    
    %view(3);
    for i=1:size(elem,1)
        
        Idxn1=find(nodes==elem(i,1));
        Idxn2=find(nodes==elem(i,2));
        n1=nodes(Idxn1,2:4);
        n2=nodes(Idxn2,2:4);
        plot3 ([n1(1) n2(1)],[n1(2) n2(2)],[n1(3) n2(3)],'linewidth',1.5,'color','k');
    end
    %xlim([-15000 15000]);
    %ylim([-15000 15000]);
    %zlim([0 2000]);
    daspect([1 1 1]);
    ax = gca;
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    %exportgraphics(fig, 'plot_bridge_2d.pdf','ContentType','vector')
end  