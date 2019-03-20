function fold_train_val_test = get_indexes(how_many_samples, k_folds)
    TRAIN = 1;
    VALIDATION = 2;
    TEST = 3;
    fold_train_val_test = zeros(k_folds, how_many_samples, 3);
    indices = cvpartition(how_many_samples, 'Kfold', k_folds);
    for i=1:10
        fold_train_val_test(i, :, TEST) = indices.test(i);
    end
    
    for k=1:10
        train_indexes = indices.training(k);
        for i=1:how_many_samples
            if train_indexes(i) == 0
                continue;
            else
                if rand < 0.15
                    fold_train_val_test(k, i, VALIDATION) = 1;
                else 
                    fold_train_val_test(k, i, TRAIN) = 1;
                end
            end
        end
    end
    
    assert(sum(logical(fold_train_val_test(1, :, 3)) & ... 
    logical(fold_train_val_test(1, :, 2)) & ...
    logical(fold_train_val_test(1, :, 1))) == 0);
    
    