function [time_to_backfill]= get_backfill_start_time(job_id)

global S;
global JOB_ID;
global scale;
global JOB_SIZE_Q;
global bin_size;

running_job_list = get_running_job_id();
sort(running_job_list);

running_job_remaining_time = zeros(1, length(running_job_list));


for i = 1: length(running_job_list)
    running_job_remaining_time(i) = get_running_job_remaining_time(running_job_list(i));
end


[sort_running_job_remaining_time,index] = sort(running_job_remaining_time);

sort_running_job_list = zeros(1,length(running_job_list));

for i = 1:length(running_job_list)
    sort_running_job_list(i) = running_job_list(index(i));
end


JOB_ID_BACKUP = JOB_ID;
S_BACKUP = S;



gap = 100;

for j = 1: gap:length(sort_running_job_list)
   for i = 1:min(gap,length(sort_running_job_list)-j+1)  
    for z = 1: scale
        for x = 1:scale
            for y = 1: scale
                if JOB_ID(x,y,z) == sort_running_job_list(i+j-1)
                    JOB_ID(x,y,z) = 0;
                    S(x,y,z,1) = 0;  
                end
            end
        end
    end
   end 

   
   free_partition_detection_largest();

    if max(bin_size) >= JOB_SIZE_Q(job_id)

        time_to_backfill = sort_running_job_remaining_time(j+ min(gap,length(sort_running_job_list)-j+1) -1);
        break;    
    end
 
end

JOB_ID = JOB_ID_BACKUP;
S = S_BACKUP;




        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    
    


