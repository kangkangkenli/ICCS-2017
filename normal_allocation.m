function normal_allocation(q_head, job_len)


global bin_counter;
global scale;
global S;
global JOB_ID;
global FLAG;
global Sen;
global JOB_SIZE_Q;
global total_bin_size;
global bin_left_size;


idle = ones(1,bin_counter)* (scale*scale*scale);


if Sen(q_head) == 0

    for bin_num = 1:bin_counter
        
        concave_one_bin_placement(bin_num,q_head,job_len)
        
        if FLAG(q_head) == 1
            total_bin_size = total_bin_size - JOB_SIZE_Q(q_head);
            break;
            
        end
    end

else    

     S_BACKUP = S;
     JOB_ID_BACKUP = JOB_ID;
     

    for bin_num = 1: bin_counter
        
        
        idle(bin_num) = one_bin_placement(bin_num, q_head, job_len);
        
    end
    [min_idle,index] = min(idle);
    
    if min_idle < scale*scale*scale

        S = S_BACKUP;
        JOB_ID = JOB_ID_BACKUP;
        idle_final = one_bin_placement(index, q_head, job_len);
        total_bin_size = total_bin_size - JOB_SIZE_Q(q_head) - idle_final;
        bin_left_size(index) = bin_left_size(index) - JOB_SIZE_Q(q_head) - idle_final;
        FLAG(q_head) = 1;
     
        
    else
        FLAG(q_head) = 0;
        
    end
end

    

 

 
 