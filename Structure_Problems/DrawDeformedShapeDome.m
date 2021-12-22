function DrawDeformedShapeDome(U,m)

    global n_elem nodes elements Aff
    
    for (i = 1:n_elem)
        
        
        n1=find(nodes(:,1)==elements(i,1));
        n2=find(nodes(:,1)==elements(i,2));  
                    
       %n1=elements(i,1)
       %n2=elements(i,2)
       
       for (j = 1:3)

            v1(j) = nodes(n1,1+j);
            v2(j) = nodes(n2,1+j);

            if (Aff(n1,j)>0)
                v1(j) = v1(j) + U(Aff(n1,j))*m;
            end

            if (Aff(n2,j)>0)
                v2(j) = v2(j) + U(Aff(n2,j))*m;
            end
       end     
       plot3 ([v1(1) v2(1)],[v1(2) v2(2)],[v1(3) v2(3)],'linewidth',1.0,'color','b');
            
    end

end  