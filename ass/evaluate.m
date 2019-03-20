function [sensitivity, specificity, false_nagative_rate, false_positive_rate] = evaluate(confusion_matrix)
    TP = confusion_matrix(1);
    TN = confusion_matrix(4);
    FP = confusion_matrix(2);
    FN = confusion_matrix(3);
    
    sensitivity = TP / (TP + FN);
    specificity = TN / (TN + FP);
    false_nagative_rate = FN / (TP + FN);
    false_positive_rate = FP / (TN + FP);