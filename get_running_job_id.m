function [running_jobs] = get_running_job_id()


global JOB_ID;
global scale;

running_jobs = zeros(1,100000);

running_job_counter = 0;

for z = 1 : scale
    for x = 1 : scale
        for y = 1 : scale
            if JOB_ID(x,y,z) ~= 0
                
                running_job_counter = running_job_counter + 1;
                running_jobs(running_job_counter) = JOB_ID(x,y,z); 
            end
        end
    end
end

running_jobs = running_jobs(find(running_jobs));
running_jobs = unique(running_jobs);





            
            
        




