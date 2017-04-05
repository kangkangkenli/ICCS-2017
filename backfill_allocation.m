function backfill_allocation(job_id)

global JOB_TIME_Q;
global JOB_SIZE_Q;
global backfill_thres;
global FLAG;
global TIME;
global cur_job;
global ALLOC;
global CAL;
global cycle;

time_to_backfill = get_backfill_start_time(job_id);
backfill_job_id = job_id + 1;
backfill_begin_time = TIME;

backfill_large_job_start_time = backfill_begin_time + ceil(time_to_backfill/cycle)*cycle;

while TIME < backfill_large_job_start_time
    
  
  if mod(TIME,cycle) == 0

    free_partition_detection();
    
   while 1 > 0 && backfill_job_id <= CAL

     if FLAG(backfill_job_id) == 0 

        if JOB_TIME_Q(backfill_job_id) + TIME <= backfill_large_job_start_time && JOB_SIZE_Q(backfill_job_id) < backfill_thres

             normal_allocation(backfill_job_id,JOB_TIME_Q(backfill_job_id));
        
             if FLAG(backfill_job_id) == 1
                 
                  ALLOC = ALLOC + 1;
                  backfill_job_id = backfill_job_id + 1;
  
             else

                  break;
             end
        else
            
             backfill_job_id = backfill_job_id + 1;
            
        end
        
     else
          
        backfill_job_id = backfill_job_id + 1; 
      
     end 
   end
    
  end
  
  system_queue_update();

end


free_partition_detection();

cur_job = job_id;

normal_allocation(cur_job,JOB_TIME_Q(cur_job));

if FLAG(cur_job) == 1
    
    ALLOC = ALLOC + 1;
    cur_job = cur_job + 1;
    
end






        
    
