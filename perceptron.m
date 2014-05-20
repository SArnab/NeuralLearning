T = 500;
eta = 0.1;

% Logical AND
w = zeros(T,3);
y = NaN(1,T);
yT = NaN(1,T);
performance = zeros(1,T);
rng('shuffle');

for i=1:T
    % Generate Random Input Vector
    x = [NaN NaN -1];
    x(1:2) = randi([0,1],1,2);
    x(x == 0) = -1;
    
    y(i) = sign(dot(w(i,:),x));
    
    if(x(1) == 1 && x(2) == 1)
        yT(i) = 1;
    else
        yT(i) = -1;
    end
       
    w(i+1,:) = w(i,:) + (eta*(yT(i) - y(i)))*x;
end
performance(y == yT) = 1;
figure(1);
plot(1:T,performance,'.k');
title('Logical AND Operation');
xlabel('Pattern Representations');
ylabel('Performance (1 = Correct, 0 = Incorrect)');

% Logical OR
w = zeros(T,3);
y = NaN(1,T);
yT = NaN(1,T);
performance = zeros(1,T);
rng('shuffle');

for i=1:T
    % Generate Random Input Vector
    x = [NaN NaN -1];
    x(1:2) = randi([0,1],1,2);
    x(x == 0) = -1;
    
    y(i) = sign(dot(w(i,:),x));
    
    if(x(1) == 1 || x(2) == 1)
        yT(i) = 1;
    else
        yT(i) = -1;
    end
       
    w(i+1,:) = w(i,:) + (eta*(yT(i) - y(i)))*x;
end
performance(y == yT) = 1;
figure(2);
plot(1:T,performance,'.k');
title('Logical OR Operation');
xlabel('Pattern Representations');
ylabel('Performance (1 = Correct, 0 = Incorrect)');

% Logical XOR
T = 1000;
w = zeros(T,3);
y = NaN(1,T);
yT = NaN(1,T);
performance = zeros(1,T);
rng('shuffle');

for i=1:T
    % Generate Random Input Vector
    x = [NaN NaN -1];
    x(1:2) = randi([0,1],1,2);
    x(x == 0) = -1;
    
    y(i) = sign(dot(w(i,:),x));
    
    if((x(1) == 1 && x(2) == -1) || (x(1) == -1 && x(2) == 1))
        yT(i) = 1;
    else
        yT(i) = -1;
    end
       
    w(i+1,:) = w(i,:) + (eta*(yT(i) - y(i)))*x;
end
performance(y == yT) = 1;
figure(3);
plot(1:T,performance,'.k');
title('Logical XOR Operation');
xlabel('Pattern Representations');
ylabel('Performance (1 = Correct, 0 = Incorrect)');