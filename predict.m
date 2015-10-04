clc; clear;


% Weights of Theta
model_weights = matfile('model.vec');
theta_gradient = model_weights.theta_gradient;
average_vector = model_weights.average_vector;
std_vector = model_weights.std_vector;

% Read in args
% args = argv();

% Input
input = [1 16 125000 8000];

% Normalize data
input(:,2:end) = (input(:,2:end)-average_vector)./(std_vector);
 
% Prediction
prediction = input*theta_gradient;
if prediction < 1
    disp('Prediction');
    disp('Failed to provide a possible result (e.g. less than 1)');
else
    disp('Prediction');
    disp(prediction);
end