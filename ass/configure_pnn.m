function net_out = configure_pnn(net_in, train_val_test)
   
    
    % Choose Input and Output Pre/Post-Processing Functions
    % For a list of all processing functions type: help nnprocess
    net_in.input.processFcns = {'removeconstantrows','mapminmax'};
    net_in.output.processFcns = {'removeconstantrows','mapminmax'};
    
    % Setup Division of Data for Training, Validation, Testing
    % For a list of all data division functions type: help nndivide
    net_in.divideFcn = 'divideind'; 
    net_in.divideParam.trainInd = find(train_val_test(1, :, 1));
    net_in.divideParam.valInd = find(train_val_test(1, :, 2));
    net_in.divideParam.testInd = find(train_val_test(1, :, 3));
    
    net_out = net_in; 