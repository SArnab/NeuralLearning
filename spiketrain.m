clc
clear

T = 5; % duration
r = 10; % spikes per second
N = 50; % trials

k = T*r; % Number of spikes within a trial
isi = NaN(1,k); % Interspike Intervals
spikes = NaN(k,N);
for i=1:N
    % Generate ISI for this train
    isi = -log(rand(k,1))/r;
    % Add to spike matrix
    spikes(:,i) = cumsum(isi);
end
% Filter this shit
spikes(spikes > T) = NaN;
figure(1);
plot(spikes,1:N,'.k');
ylabel('Trial');
xlabel('Time (s)');
title('Raster Plot for a Poisson Spike Train');

% Check firing rates
divisor = N*T;
avgF = length(spikes(~isnan(spikes))) / divisor;
fprintf('Average firing rate: %0.4f\n',avgF);

% Check firing rate per bin
step = 0.2;
binCount = T/step;
bins = zeros(1,binCount);
midpoints = zeros(1,binCount);
divisor = N*step;
for i=1:binCount
    min = (i-1)*0.2;
    max = i*0.2;
    midpoints(i) = 0.5*(min+max);
    bins(i) = length(spikes(~isnan(spikes) & spikes>=min & spikes <= max)) / divisor;
end
figure(2);
plot(midpoints,bins);
xlabel('Time (s)');
ylabel('Firing Rate (spikes/s)');
binM = mean(bins);
binV = var(bins);
binD = std(bins);
binVar = binD / binM;
fprintf('Mean of bins: %0.4f\nVariance of bins: %0.4f\nStd. Deviation of bins: %0.4f\nVariation of bins: %0.4f\n',binM,binV,binD,binVar);

% Compute the coefficient of variability
isi = NaN(k-1,N);
cv = zeros(1,N);
for i=1:N
    isi(:,i) = diff(spikes(:,i));
    v = isi(:,i);
    v = v(~isnan(v));
    cv(i) = std(v)/mean(v);
end
figure(3);
plot(1:N,cv,'.k');
ylabel('Coefficient of Variance');
xlabel('Trial');
title('Coefficient of Variance Across Trails');
fprintf('Mean CV: %0.4f\n',mean(cv));
hold off;

% Compute the Fano Factor
count = zeros(1,N);
for i=1:N
    v = spikes(:,i);
    count(i) = length(v(~isnan(v)));
end
gAvg = mean(count);
gVar = var(count);
ff = gVar / gAvg;
fprintf('Fano Factor: %0.4f\n',ff);