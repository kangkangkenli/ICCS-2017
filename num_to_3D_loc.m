function [num_x,num_y,num_z] = num_to_3D_loc(num,j)

global S;
global l_x;
global l_y;
global l_z;
global r_x;
global r_y;
global r_z;

for z = l_z(j):r_z(j)
        for x = l_x(j):r_x(j)
            for y = l_y(j):r_y(j)
                if S(x,y,z,2) == num
                    num_x = x;
                    num_y = y;
                    num_z = z;
                    return;
                end
            end
        end
 end
                

