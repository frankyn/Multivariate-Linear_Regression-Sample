clc; clear;

% load csv file
allCoMDanalysis = load('data.csv');

% Normalization of data
% Calculate mean of each column
averages_vector = repmat(mean(allCoMDanalysis),length(allCoMDanalysis),1);

% Calculate mean normalization
standard_deviation = repmat(std(allCoMDanalysis), length(allCoMDanalysis),1);

% feature normalize
mean_normalized_data = allCoMDanalysis;
mean_normalized_data(:,2:end) = (allCoMDanalysis(:,2:end)-averages_vector(:,2:end))./(standard_deviation(:,2:end));

% Ground Truth
y_ground = mean_normalized_data(:,1);

% Features
features = [ones(size(mean_normalized_data,1),1) mean_normalized_data(:,2:4)];

% Theta (Weights) Set Weights Randomly
theta_gradient = zeros(size(features,2),1);

% Split into Training and Test Set
% 70 - 30 split  (70 - training , 30 - test )
training_size = floor(size(features,1)*.70);
training_features = features(1:training_size,:);
training_ground = y_ground(1:training_size,:);

% Test set (30 - test)
test_size = size(features,1)-training_size;
test_set = features(training_size:training_size+test_size,:);
test_ground = y_ground(training_size:training_size+test_size,:);

% Gradient Descent (Numerical Methods)
learning_rate = 0.01;
iterations = 100000;

% Gradient Descent Iterations
for m=1:iterations
    theta_gradient = theta_gradient-(learning_rate*(1/training_size)*...
           (((training_features*theta_gradient)-training_ground)'*...
           training_features)');
end 

% Test Error
error_gradient = 1/(2*test_size)*(test_set*theta_gradient-test_ground)'...
                                *(test_set*theta_gradient-test_ground);
disp('Cost Function Error ( Gradient Descent )');
disp(error_gradient);

% Setup Normalization Values
average_vector = averages_vector(1:1,2:4);
std_vector = standard_deviation(1:1,2:4);

% Save the weights into a file
save model.vec theta_gradient average_vector std_vector 

