function [job_time] = get_running_job_remaining_time(job_id)
global S;
global scale;
global JOB_ID;

for z = 1:scale
        for x = 1:scale
            for y = 1:scale
               if JOB_ID(x,y,z) == job_id
                   if S(x,y,z,1) >= 25000
                        job_time = S(x,y,z,1)- 25000;
                        return;
                   end
               end
            end
        end
end

