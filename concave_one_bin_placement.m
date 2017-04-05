function concave_one_bin_placement(j,q_head,job_len)

global S;
global JOB_ID;
global FLAG;
global tail;
global head;
global JOB_SIZE_Q;
job_size = JOB_SIZE_Q (q_head);
global bin_left_size;
global tail_bin;


if tail(j)- job_size + 1 >= head(j)
   
    for number = tail(j):-1:tail(j)- job_size + 1

        [x,y,z] = num_to_3D_loc(number,j); 
        S(x,y,z,1) = job_len + 25000;
        JOB_ID( x,y,z) = q_head;
        
    end
    FLAG(q_head) = 1;
    tail(j) = tail(j) - job_size;
    bin_left_size(j) = bin_left_size(j) - job_size;
    tail_bin(j) = tail(j)-head(j);
 

end
