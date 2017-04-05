
function data()
global T;
global N;
global T_1;
global N_1;

total = 170+154;
T_1 = [ones(1,170), randi([2 10],1,154)];

for i = 11:10:171
    test_data = importdata('trace.csv');
    a = test_data.textdata(:,7);
    C = char(a);
    tt=datenum(C);
    r=round(86400*mod(tt,1));
    r(r==0)=r(r==0)+1;
    r = ceil (r./60);
    r = r';
    e=find(r<=i-1);
    f = find(r<=i+9);
    b = length(f)-length(e);
    b = b/69590*1500;
    t = randi([i,i+9],1,ceil(b));
    total = total + ceil(b);

    T_1 = [T_1,t];
end

for i = 181:60:1381
    
    test_data = importdata('trace.csv');
    a = test_data.textdata(:,7);
    C = char(a);
    tt=datenum(C);
    r=round(86400*mod(tt,1));
    r(r==0)=r(r==0)+1;
    r = ceil (r./60);
    r = r';
    e=find(r<=i-1);
    f = find(r<=i+59);
    b = length(f)-length(e);
    b = b/69590*1500;
    t = randi([i,i+9],1,ceil(b));
    total = total + ceil(b);

    T_1 = [T_1,t];
end

T_1= T_1(randperm(numel(T_1)));


total_N = 1114;
N_1 = ones(1,1114);

for j = 2:10  
    test_data = importdata('trace.csv');
    b = test_data.textdata(:,8);
    Y = cellfun(@str2num,b);
    Y = Y';
    Y = Y./2;
    Z= round (Y);  
    h = find(Z<=j-1);
    m = find(Z<=j);
    k = length(m)-length(h);
    k = k/67745*1500;
    n = ones(1,ceil(k))*j;
    total_N = total_N + ceil(k);
    
    N_1 = [N_1,n];
 
end

for j = 11:10:100
    test_data = importdata('trace.csv');
    b = test_data.textdata(:,8);
    Y = cellfun(@str2num,b);
    Y = Y';
    Y = Y./2;
    Z= round (Y);  
    h = find(Z<=j-1);
    m = find(Z<=j+9);
    k = length(m)-length(h);
    k = k/67745*1500;
    n = randi([j,j+9],1,ceil(k));
    total_N = total_N + ceil(k);
    
    N_1 = [N_1,n];

    
end

N_1= N_1(randperm(numel(N_1)));


total = 225+200;
T = [ones(1,225), randi([2 10],1,200)];

for i = 11:10:171
    
    test_data = importdata('trace.csv');
    a = test_data.textdata(:,7);
    C = char(a);
    tt=datenum(C);
    r=round(86400*mod(tt,1));
    r(r==0)=r(r==0)+1;
    r = ceil (r./60);
    r = r';
    e=find(r<=i-1);
    f = find(r<=i+9);
    b = length(f)-length(e);
    b = b/69590*2000;
    t = randi([i,i+9],1,ceil(b));
    total = total + ceil(b);

    T = [T,t];
end

for i = 181:60:1381
    
    test_data = importdata('trace.csv');
    a = test_data.textdata(:,7);
    C = char(a);
    tt=datenum(C);
    r=round(86400*mod(tt,1));
    r(r==0)=r(r==0)+1;
    r = ceil (r./60);
    r = r';
    e=find(r<=i-1);
    f = find(r<=i+59);
    b = length(f)-length(e);
    b = b/69590*2000;
    t = randi([i,i+9],1,ceil(b));
    total = total + ceil(b);

    T = [T,t];
end

T= T(randperm(numel(T)));


total_N = 1459;
N = ones(1,1459);

for j = 2:10  
    test_data = importdata('trace.csv');
    b = test_data.textdata(:,8);
    Y = cellfun(@str2num,b);
    Y = Y';
    Y = Y./2;
    Z= round (Y);  
    h = find(Z<=j-1);
    m = find(Z<=j);
    k = length(m)-length(h);
    k = k/68279*2000;
    n = ones(1,ceil(k))*j;
    total_N = total_N + ceil(k);
    
    N = [N,n];
   
end

for j = 11:10:141
    test_data = importdata('trace.csv');
    b = test_data.textdata(:,8);
    Y = cellfun(@str2num,b);
    Y = Y';
    Y = Y./2;
    Z= round (Y);  
    h = find(Z<=j-1);
    m = find(Z<=j+9);
    k = length(m)-length(h);
    k = k/68279*2000;
    n = randi([j,j+9],1,ceil(k));
    total_N = total_N + ceil(k);
    
    N = [N,n];

    
end

N= N(randperm(numel(N)));





