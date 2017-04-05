function [idle_node_number] = one_bin_placement_bin_job(j,q_head,job_len)

% place job to jth bin
global S;
global JOB_ID;
global l_x;
global l_y;
global l_z;
global r_x;
global r_y;
global r_z;
global scale;
global FLAG;
global head;
global tail_head;

counter_bin = 0;
total_bin_size = (r_y(j)-l_y(j)+1)*(r_x(j)-l_x(j)+1)*(r_z(j)-l_z(j)+1);
req_size = total_bin_size ;

for number = 1:total_bin_size

    [x,y,z] = num_to_3D_loc(number,j);
    
    if S(x,y,z,1) == 0 
        
        counter_bin = counter_bin + 1;
    else
        break;
  
    end
end      

if counter_bin == req_size
    
    for num = 1 : total_bin_size
       [x,y,z] = num_to_3D_loc(num,j); 
       S(x,y,z,1) = job_len + 25000;
       JOB_ID( x,y,z) = q_head;
    end
    FLAG(q_head) = 1;
    head(j) = total_bin_size + 1; 
    tail_head(j) = -1;
    idle_node_number = 0;
    return;
end

idle_node_number = scale*scale*scale;


