function [idle_number] = one_bin_placement(j, q_head,job_len) 

global l_x;
global l_y;
global r_x;
global r_y;
global l_z;
global r_z;
global JOB_SIZE_Q;


job_size = JOB_SIZE_Q (q_head);



plane = (r_y(j)-l_y(j)+1)*(r_x(j)-l_x(j)+1);
line = r_y(j)-l_y(j)+1;
bin = (r_y(j)-l_y(j)+1)*(r_x(j)-l_x(j)+1)*(r_z(j)-l_z(j)+1);
global scale;


if job_size > bin

        idle_number = scale*scale*scale;
    
    elseif job_size == bin

        idle_number = one_bin_placement_bin_job(j,q_head,job_len);
    
    elseif job_size >= plane && job_size < bin

        idle_number = one_bin_placement_3D_job(j,q_head,job_len);

    elseif job_size >= line && job_size < plane
   
        idle_number = one_bin_placement_2D_job(j,q_head,job_len);
    
    else
        idle_number = one_bin_placement_1D_job(j,q_head,job_len);

 
end
