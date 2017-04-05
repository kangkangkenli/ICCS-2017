function job_allocation_session()


global ALLOC;
global FLAG; 
global JOB_TIME_Q;
global backfill_number;
global buffer_size;
global cur_head;
global cur_job;
global START_INPUT;
global RUN_INPUT;


 
while 1 > 0 && cur_job <= min(cur_head + buffer_size, START_INPUT + RUN_INPUT)
      
  if FLAG(cur_job) == 0

           normal_allocation(cur_job,JOB_TIME_Q(cur_job));
           
           if FLAG(cur_job) == 1
               
               ALLOC = ALLOC + 1;
               cur_job = cur_job + 1;

           else
               
               backfill_allocation(cur_job);
               backfill_number = backfill_number + 1; 
           end
           
  else
      cur_job = cur_job + 1 ;    
  
   end

end
