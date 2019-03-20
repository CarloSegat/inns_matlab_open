load('loaded.mat');
[x, y] = load_data(data);

data = [normed, ys];
TP = [1];
TN = [4];
FP = [2];
FN = [3];

spreads = [0.05, 0.1, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45, 0.50];
spreads_fine = [0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1,0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.20];
spreads_finer = [0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01];

sensitivity = [];
specificity = [];
false_negative_count = [];
false_positive_count = [];
performances = zeros(40, 50);

%train_x_noGnoI = train_x;
%test_x_noGnoI = test_x;
%train_x_noGnoI(:, 5) = [];
%train_x_noGnoI(:, 4) = [];
%test_x_noGnoI(:, 5) = [];
%test_x_noGnoI(:, 4) = []; 
for kval = 1:50
    d = mahal(data(:, 1:9), data(:, 1:9)); 
    mean_distance = mean(d);
    std_distance = std(d);
    outliers_indexes = d > mean_distance + std_distance;
    count = sum(outliers_indexes);
    for c = 1:length(outliers_indexes)
        if count == 34
            break
        end
        if outliers_indexes(c) ~= 1
            if rand > 0.5
                outliers_indexes(c) = 1;
                count = count + 1;
            end
        end
    end 

%     train_noout_x = data(~outliers_indexes, 1:9);
%     train_noout_y = data(~outliers_indexes, 10); 
%     test_noout_x = data(outliers_indexes, 1:9);
%     test_noout_y = data(outliers_indexes, 10); 

    cv = cvpartition(size(data,1),'HoldOut',0.3);
    idx = cv.test; 

    train_noout_x = data(~idx, 1:9);
    train_noout_y = data(~idx, 10);
    train_noout_y = ind2vec(train_noout_y');  
    test_noout_x = data(idx, 1:9);
    test_noout_y = data(idx, 10); 

    for n = 10 : 40
        net = patternnet(n);
        net = train(net, x', y'); 
        %net = newpnn(train_noout_x', train_noout_y, spreads_fine(n));
        %output = net(test_noout_x');
        
        %output_1d = output(1, :) >= 0.5;
        %output_1d = output_1d + 1;
        
        %perf = perform(net, test_noout_y', output_1d);  

        %cm = confusionmat(test_noout_y', output_1d);

        inner_loop_steps = 31;
        index = n + ((kval-1)*inner_loop_steps); 
%         sensitivity(index) = cm(TP) / (cm(TP) + cm(FN));
%         specificity(index) = cm(TN) / (cm(TN) + cm(FP));
%         false_negative_count(index) = cm(FN);
%         false_positive_count(index) = cm(FP);
        %performances(n,kval) = perf;

        %sum(result(:) == 1)
    end
end
% mean(sensitivity)
% mean(specificity)
% mean(false_negative_count) 
% mean(false_positive_count) 

