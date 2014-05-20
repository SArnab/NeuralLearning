fMax = 200; %maximum rate spikes/s
theta = 20; %threshold mV
N = 100; %Neuron count
tau = .01; %Membrane time constant s
fIn = 0:1:150; %Input Firing Rate spikes/s

% Smallest Value of J That Gives 3 Intersections
J = 0.2;
% Mu Parameter
mu = fIn*J*N*tau;
% Sigma Parameter
sigma = J*sqrt(N*fIn*tau);
% Calculate the Response function
num = -1*(sqrt(2)*(mu-theta));
den = sigma*sqrt(N);
phi = fMax ./ (1.+exp(num./den));
plot(fIn,phi,fIn,fIn);
ylabel('f_O_u_t');
xlabel('f_I_n');
legend('Response J = 0.2','Linear Firing Rate');

% Simulate The Network
tau = .01; % Membrane time constant s
T = 0.5; % Duration s
dT = 0.0001; % Timestep s
tV = 0:dT:T;
n = length(tV);

figure(2);
xlabel('Time (s)');
ylabel('Firing Rate (spikes/s)');
hold on;
for f0 = 0:150
    f = zeros(1,n);
    f(1) = f0;
    for i = 1:n-1
        mu = f(i)*J*N*tau;
        sigma = J*sqrt(N*f(i)*tau);
        num = -1*(sqrt(2)*(mu-theta));
        den = sigma*sqrt(N);
        phi = fMax / (1+exp(num/den));
        
        dF = (-f(i) + phi)/tau;
        f(i+1) = f(i) + dT*(dF);
    end
    plot(tV,f);
end