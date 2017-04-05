function free_partition_detection()

global l_x;
global l_y;
global l_z;
global r_x;
global r_y;
global r_z;
global bin_size;

global bin_counter;
global scale;
global S;
bin_counter = 0;
global total_bin_size;
total_bin_size = 0;
global bin_left_size;
global tail_head;


l_x = zeros (1, 100);
l_y = zeros (1, 100);
l_z = zeros (1, 100);
r_x = zeros (1, 100);
r_y = zeros (1, 100);
r_z = zeros (1, 100);
bin_size = zeros(1,100);
bin_left_size = zeros(1,100); 

while 1>0
       vol_max = 0;   

       for down=1:scale
            DOWN= S(:,:,down,1);

            X = DOWN;
            
           for up=down:scale
             UP = S(:,:,up,1);

                    for i=1:scale
                         for j=1:scale
                            if X(i,j)==0 && UP(i,j)==0
                                  X(i,j)=0;
                            else
                                  X(i,j)=1;
                            end
                         end
                    end
              max = 0;
              lx = 0;
              ly = 0;
              rx = 0;
              ry = 0;
              h = zeros(1,scale);
              l = zeros(1,scale);
              r = zeros(1,scale);
              
              for i = 1:scale
                  for j = 1:scale
                      if  X(i,j) == 0
                          h (j) = h(j)+1;
                      else
                          h (j) = 0;
                      end
                  end
                  for j = 1:scale
                      l(j) = j;
                      while l(j)>1 && h (j)<= h(l(j)-1)
                          l(j)=l(l(j)-1);
                      end
                  end
                  for j = scale:-1:1
                      r(j)=j;
                       while r(j)< scale && h(j)<=h(r(j)+1)
                           r(j)=r(r(j)+1);
                       end
                  end
                  for j = 1:scale
                      if max<h(j)*(r(j)-l(j)+1)
                         max=h(j)*(r(j)-l(j)+1);
                         rx=i;
                         ry=r(j);
                         ly=l(j);
                         lx=i-h(j)+1;
                      end
                  end
              end
             
              if (up-down +1)* max > vol_max

                  vol_max=(up-down+1)* max;
                  up_max= up;
                  down_max = down;
                  lx_max = lx;
                  ly_max =ly;
                  rx_max =rx;
                  ry_max =ry;

              end
           end
       end

      if vol_max <=0
          break;
      else

                bin_counter = bin_counter + 1;   
                l_x(bin_counter) = lx_max;
                l_y(bin_counter) = ly_max;
                r_x(bin_counter) = rx_max;
                r_y(bin_counter) = ry_max;  
                r_z(bin_counter) = up_max;
                l_z (bin_counter) = down_max;
                bin_size(bin_counter)=vol_max;

      end  
      for k =down_max:up_max
           for i=lx_max:rx_max
               for j = ly_max:ry_max
                     S(i,j,k,1)= 50000;
                  
                end
           end
      end
      
end

  for i = 1: bin_counter
   for z = l_z(i):r_z(i)
     for x = l_x(i): r_x(i)
        for y = l_y(i):r_y(i)
                S(x,y,z,1) = 0;
        end
     end
    end
  end



l_x = l_x(find(l_x));
r_x = r_x(find(r_x));
l_y = l_y(find(l_y));
r_y = r_y(find(r_y));
l_z = l_z(find(l_z));
r_z = r_z(find(r_z));
bin_size = bin_size(find(bin_size));


for k= 1: bin_counter
    x=l_x(k);
    y=l_y(k);
    z=l_z(k);
    S(l_x(k),l_y(k),l_z(k),2)=1;
    
   while z < r_z(k)
        
       if x==l_x(k) && z<r_z(k)
           
            while  x < r_x(k)
                
                if y==l_y(k) && x<r_x(k)
                    
                    while y < r_y(k)
                        S(x,y+1,z,2)=S(x,y,z,2)+1;
                        y=y+1;
                    end
                     
                     S(x+1,y,z,2)=S(x,y,z,2)+1;
                     x=x+1;
                
                
                elseif y==r_y(k) && x<r_x(k)
                    
                    while y > l_y(k)
                        S(x,y-1,z,2)=S(x,y,z,2)+1;
                        y=y-1;
                    end
                    
                    S(x+1,y,z,2)=S(x,y,z,2)+1;
                    x=x+1;
                end
            end

            
            if x==r_x(k) && z<r_z(k)
                
                if y==l_y(k)
                    
                    while y <r_y(k)
                        S(x,y+1,z,2)=S(x,y,z,2)+1;
                        y=y+1;
                    end
                                  
                elseif y==r_y(k)
                    
                     while y > l_y(k)
                        S(x,y-1,z,2)=S(x,y,z,2)+1;
                        y=y-1;
                     end
                 end
             end

             
             S(x,y,z+1,2)=S(x,y,z,2)+1;
             z=z+1;  
       
       elseif x==r_x(k) && z<r_z(k)
           
           while x >l_x(k)
               
               if y==l_y(k) && x > l_x(k)
                   
                   while y < r_y(k)
                       S(x,y+1,z,2)=S(x,y,z,2)+1;
                       y=y+1;
                   end
                   
                   S(x-1,y,z,2)=S(x,y,z,2)+1;
                   x=x-1;
               
               
               elseif y==r_y(k) && x > l_x(k)
                   
                    while y > l_y(k)
                        S(x,y-1,z,2)=S(x,y,z,2)+1;
                        y=y-1;
                    end
                       
                    S(x-1,y,z,2)=S(x,y,z,2)+1;
                    x=x-1;
               end
           end    

           if x==l_x(k) && z< r_z(k)
                   if y==l_y(k)
                       
                       while y <r_y(k)
                           S(x,y+1,z,2)=S(x,y,z,2)+1;
                           y=y+1;
                       end
                       
                   elseif y==r_y(k)
                       
                       while y > l_y(k)
                           S(x,y-1,z,2)=S(x,y,z,2)+1;
                           y=y-1;
                       end
                   end
  
           end            
           S(x,y,z+1,2)=S(x,y,z,2)+1;
           z=z+1; 
       end
   end
   
  if z==r_z(k)
       
     if x==l_x(k)
           
           while x<r_x(k)
               
               if y==l_y(k)&& x<r_x(k)
                   
                   while y <r_y(k)
                       S(x,y+1,z,2)=S(x,y,z,2)+1;
                       y=y+1;
                   end
                   
                   S(x+1,y,z,2)=S(x,y,z,2)+1;
                   x=x+1;
               
               
               elseif y==r_y(k)&& x<r_x(k)
                   
                   while y > l_y(k)
                       
                       S(x,y-1,z,2)=S(x,y,z,2)+1;
                       y=y-1;
                   end
                   
                   S(x+1,y,z,2)=S(x,y,z,2)+1;
                   x=x+1;
               end    
           end
           
           if x==r_x(k)
               
               if y==l_y(k)
                   
                   while y <r_y(k)
                       
                       S(x,y+1,z,2)=S(x,y,z,2)+1;
                       y=y+1;
                   end
                    
               elseif y==r_y(k)
                   while y > l_y(k)
                       
                       S(x,y-1,z,2)=S(x,y,z,2)+1;
                       y=y-1;
                   end
                   
               end
           end
           
           
      elseif x==r_x(k)
           
           while x >l_x(k)
               
               if y==l_y(k) && x > l_x(k)
                   
                   while y < r_y(k)
                       S(x,y+1,z,2)=S(x,y,z,2)+1;
                       y=y+1;
                   end
                   
                   S(x-1,y,z,2)=S(x,y,z,2)+1;
                   x=x-1;
               
               
               elseif y==r_y(k) && x > l_x(k)
                   
                   while y > l_y(k)
                       S(x,y-1,z,2)=S(x,y,z,2)+1;
                       y=y-1;
                   end
                   
                   S(x-1,y,z,2)=S(x,y,z,2)+1;
                   x=x-1;
               end
           end
           
           if x==l_x(k)
                   
                   if y==l_y(k)
                       while y <r_y(k)
                           
                           S(x,y+1,z,2)=S(x,y,z,2)+1;
                           y=y+1;
                       end
                       
                   elseif y==r_y(k)
                       
                       while y > l_y(k)
                           
                           S(x,y-1,z,2)=S(x,y,z,2)+1;
                           y=y-1;
                       end
                   end
            end
               
    end
  end
end

[bin_size,index] = sort(bin_size);

l_x_temp = zeros(1, bin_counter);
l_y_temp = zeros(1, bin_counter);
l_z_temp = zeros(1, bin_counter);
r_x_temp = zeros(1, bin_counter);
r_y_temp = zeros(1, bin_counter);
r_z_temp = zeros(1, bin_counter);


for bin_num = 1: bin_counter
    l_x_temp(bin_num) = l_x(index(bin_num));
   
    r_x_temp(bin_num) = r_x(index(bin_num));
 
    l_y_temp(bin_num) = l_y(index(bin_num));
    
    r_y_temp(bin_num) = r_y(index(bin_num));
  
    l_z_temp(bin_num) = l_z(index(bin_num));

    r_z_temp(bin_num) = r_z(index(bin_num));
    
end 


l_x = l_x_temp;
l_y = l_y_temp;
l_z = l_z_temp;
r_x = r_x_temp;
r_y = r_y_temp;
r_z = r_z_temp;


for bin_num = 1: bin_counter

    total_bin_size = total_bin_size + bin_size(bin_num);
    bin_left_size(bin_num) = bin_size(bin_num);
    
end 


global tail;
tail = zeros(1,bin_counter);

global head;
head = zeros(1,bin_counter);

for bin_num = 1: bin_counter
    
    head(bin_num) = 1;
    
    tail(bin_num) = bin_size(bin_num);
    tail_head(bin_num) = tail(bin_num) - head(bin_num);
end



