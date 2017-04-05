function [idle_node_number] = one_bin_placement_3D_job(j,q_head,job_len)

global S;
global JOB_ID;
global FLAG;

global l_x;
global l_y;
global r_x;
global r_y;
global JOB_SIZE_Q;
global scale;
job_size = JOB_SIZE_Q (q_head);
global head;
global tail;
global tail_head;

plane = (r_y(j)-l_y(j)+1)*(r_x(j)-l_x(j)+1);
req_size = ceil(job_size/plane) * plane;

counter_3D = 0;

for number = 1:tail(j)

    [x,y,z] = num_to_3D_loc(number,j);

    
    if S(x,y,z,1) == 0 && mod(number,plane) == 1
        
        cur_num = number;

        for num = cur_num : min(cur_num + req_size - 1,tail(j))
  
                [x,y,z] = num_to_3D_loc(num,j);
 
                if S(x,y,z,1) == 0
                    
                    counter_3D = counter_3D + 1;
                else
                    
                    break;
                end
  
        end
        
        if counter_3D == req_size
            
            for num = cur_num : cur_num + job_size - 1
                
                [x,y,z] = num_to_3D_loc(num,j); 
                S(x,y,z,1) = job_len + 25000;
                JOB_ID( x,y,z) = q_head;
            end
            
            for num = cur_num + job_size : cur_num + req_size - 1
                
                [x,y,z] = num_to_3D_loc(num,j); 
                S(x,y,z,1) = job_len + 15000;
                JOB_ID( x,y,z) = q_head;
            end

            FLAG(q_head) = 1;
            head(j) = max(cur_num + req_size,head(j));    
            tail_head(j) = tail(j)-head(j);
            idle_node_number = req_size - job_size;    
            return;             
            
        else
            
            counter_3D = 0;
            
        end
    end
end

idle_node_number = scale*scale*scale;


