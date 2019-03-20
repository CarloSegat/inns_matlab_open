function [x, y] = load_data(data)
    
    x = normc(data(:, 1:9));
    x = x';
    y = data(:, 10);
    y = y';
    y = ind2vec(y);
    %y = y';