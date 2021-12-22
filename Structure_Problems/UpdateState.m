% Update the lenght and hte orientation of the element with nodes n1 and n2 due to the displacement U
function [L, dir]=UpdateState(n1,n2,U)

    global nodes Aff

	v1(3)=0;
	v2(3)=0;
    
	for (j = 1:3)

		v1(j) = nodes(n1,j);
		v2(j) = nodes(n2,j);

		if (Aff(n1,j)>0)
			v1(j) = v1(j) + U(Aff(n1,j));
        end
		if (Aff(n2,j)>0)
			v2(j) = v2(j) + U(Aff(n2,j));
        end
    end

	L = norm (v2-v1);
    
	dir(1) = (v2(1) - v1(1)) / L;
	dir(2) = (v2(2) - v1(2)) / L;
	dir(3) = (v2(3) - v1(3)) / L;

  end
        
