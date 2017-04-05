function system_queue_update()

global S;
global JOB_ID;
global ALLOC;
global TIME;
global scale;
global UTL;
global cycle;

utl=0;  
    
for k=1:scale
     for i=1:scale
       for j=1:scale
          if S(i,j,k,1)>25000
            utl=utl+1; 
          end
       end
     end
end

while 1>0

    TIME = TIME+1;
     
    for k=1:scale
     for i=1:scale
       for j=1:scale           
          if S(i,j,k,1)>15000
            S(i,j,k,1)=S(i,j,k,1)-1;  
          end
           if S(i,j,k,1)==25000
              S(i,j,k,1)=0;
              JOB_ID(i,j,k) = 0;
           end
           
           if S(i,j,k,1)==15000
              S(i,j,k,1)=0;
              JOB_ID(i,j,k)= 0;
           end      
       end
     end
    end 
    
 
    if mod (TIME,cycle) == 0
             break;
    end 

end
 
UTL(ceil(TIME/cycle))= utl/scale/scale/scale*100;
fprintf('time goes is %d\n', TIME);
fprintf('allocated job number is %d\n', ALLOC);
fprintf('utl is %d\n', utl);
fprintf('average utl  is %f\n', UTL(ceil(TIME/cycle)));
UTL = UTL(find(UTL));



