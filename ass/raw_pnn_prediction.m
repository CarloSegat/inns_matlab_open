function raw_prediction = raw_pnn_prediction(net, x)
    IW = net.IW{1};
    b = net.b{1};
    LW = net.LW{2};
    
    euclidean_distance = dist(IW, x);
    biased = euclidean_distance .* b;
    gaussian_output = radbas(biased);
    raw_prediction = LW * gaussian_output;