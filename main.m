function main()
global CAL;
CAL = 387400;
global ALLOC;
ALLOC = 0;
global TIME;
TIME = 0;
global FLAG; 
FLAG = zeros(1,CAL);
global Sen;
global START_INPUT;
global RUN_INPUT;
START_INPUT = 1520;
RUN_INPUT = 2010;

sen_0 = zeros(1,ceil(START_INPUT/10*0));
sen_1 = ones(1,floor(START_INPUT/10*10));
sen = [sen_0,sen_1];
sen = sen(randperm(numel(sen)));

Sen_0 = zeros(1, ceil(RUN_INPUT/10*5));
Sen_1 = ones(1, floor(RUN_INPUT/10*5));

SEN = [Sen_0,Sen_1];
SEN = SEN(randperm(numel(SEN)));

global scale;
scale = 24;
global cycle;
cycle = 15;
global UTL;
UTL= zeros(1,CAL);
global backfill_thres;
backfill_thres = 25;
global migration_thres;
migration_thres = 24;
global zigzag_success;
global zigzag_counter;
zigzag_counter = 0;
zigzag_success = 0;
global JOB_SIZE_Q;
global JOB_TIME_Q;
global T;
global N;
global T_1;
global N_1;
global UTL_pack_total;

data();

JOB_SIZE_Q = N_1;
JOB_TIME_Q = T_1;
Sen = sen;

for i = 1: 192
    JOB_SIZE_Q = [JOB_SIZE_Q,N];
    JOB_TIME_Q = [JOB_TIME_Q,T];
    Sen = [Sen, SEN];
end


global JOB_ID;
global S;

JOB_ID = zeros(scale,scale,scale);
S = zeros(scale,scale,scale,3);


global cur_job;
cur_job = 1;
global migration_call;
migration_call = 0;
global migration_success_number;
migration_success_number = 0;
global backfill_number;
backfill_number = 0;
global cur_head;
global buffer_size;
buffer_size = 1500;

 
free_partition_detection();

S(:,:,:,3) = S(:,:,:,2);

while ALLOC <= START_INPUT && cur_job <= START_INPUT

    
    first_bin_placement(1,cur_job,JOB_TIME_Q(cur_job));

    if FLAG(cur_job) == 1
        ALLOC = ALLOC + 1; 
        cur_job = cur_job + 1; 
    else
        break;
    end

end


while cur_job <= START_INPUT + RUN_INPUT

 cur_head = cur_job;
 
    while cur_job <= min(cur_head + buffer_size, START_INPUT + RUN_INPUT)
     if mod(TIME,cycle) == 0
        
        free_partition_detection();
        
        job_allocation_session();

     end
     system_queue_update();

    end   
end

UTL(length(UTL)) =[];
UTL_pack_total = [UTL_pack_total, UTL];

       
               
               
               
               
            