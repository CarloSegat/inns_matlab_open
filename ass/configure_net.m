function net_out = configure_net(net_in, train_func, train_val_test, lr)
    net_in.trainFcn = train_func;
    
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
    
%     net_in.divideParam.trainRatio = 70/100;
%     net_in.divideParam.valRatio = 15/100;
%     net_in.divideParam.testRatio = 15/100;
    
    net_in.performFcn = 'crossentropy';  % Cross-Entropy
    
    net_in.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
        'plotconfusion', 'plotroc'};
    
    %net_in.trainParam.lr = lr;
    
    net_out = net_in;