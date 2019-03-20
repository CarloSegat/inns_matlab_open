load('loaded.mat');
[x, y] = load_data(data);
t = y;

spreads = [0.004, 0.008, 0.012, 0.016, 0.02 , 0.024, 0.028, 0.032,...
            0.036, 0.04 , 0.044, 0.048, 0.052, 0.056, 0.06 , 0.064, 0.068,...
            0.072, 0.076, 0.08 , 0.084, 0.088, 0.092, 0.096, 0.1  , 0.104,...
            0.108, 0.112, 0.116, 0.12 , 0.124, 0.128, 0.132, 0.136, 0.14 ,...
            0.144, 0.148, 0.152, 0.156, 0.16 , 0.164, 0.168, 0.172, 0.176,...
            0.18 , 0.184, 0.188, 0.192, 0.196];
performances = zeros(length(spreads));
        
cross_entropy = 0;
all_indexes = get_indexes(116, 10);
train_and_validation = all_indexes(:, :, 1) + all_indexes(:, :, 2);
all_indexes = cat(3, train_and_validation, all_indexes(:, :, 3));
assert(sum(sum(all_indexes(:, :, 1) == all_indexes(:, :, 2))) == 0);

for s=1:length(spreads)
    for k=1:10
        fold_train_x = x(:, logical(all_indexes(k, :, 1)));
        fold_train_y = t(:, logical(all_indexes(k, :, 1)));
        fold_test_x = x(:, logical(all_indexes(k, :, 2)));
        fold_test_y = t(:, logical(all_indexes(k, :, 2)));
        net = newpnn(fold_train_x,  fold_train_y, spreads(s));
        raw_pnn_prediction(net, fold_test_x(:, 1));
        predicted_y = net(fold_test_x);
        %performance = perform(net,t(logical(all_indexes(k,:,3))),predicted_y);
        %view(net)

        cross_entropy = cross_entropy + crossentropy(net,t(logical(all_indexes(k,:,3))),predicted_y);

    end
    performcances(arch_index, train_index) = cross_entropy / 10;
    cross_entropy = 0;
    loss_used(arch_index, train_index) = tr.performFcn;
       
  
end
