% Ορισμός των συναρτήσεων
f1 = @(x) (x - 2).^2 + x .* log(x + 3); % f1(x) = (x - 2)^2 + x * ln(x + 3)
f2 = @(x) exp(-2*x) + (x - 2).^2; % f2(x) = e^(-2x) + (x - 2)^2
f3 = @(x) exp(x) .* (x.^3 - 1) + (x - 1) .* sin(x); % f3(x) = e^x * (x^3 - 1) + (x - 1) * sin(x)

% Αρχικό διάστημα [a, b]
a_init = -1;
b_init = 3;

% Σταθερή τιμή epsilon
epsilon = 0.001;

% Διαφορετικές τιμές για το l
l_values = [0.01, 0.05, 0.1, 0.2, 0.5]; % Δοκιμάστε διάφορες τιμές του l
num_calculations_f1 = zeros(size(l_values)); % Πίνακας για αποθήκευση υπολογισμών για f1
num_calculations_f2 = zeros(size(l_values)); % Πίνακας για αποθήκευση υπολογισμών για f2
num_calculations_f3 = zeros(size(l_values)); % Πίνακας για αποθήκευση υπολογισμών για f3

% Βρόχος για διαφορετικές τιμές του l
for i = 1:length(l_values)
    l = l_values(i); % Επιλέγουμε το τρέχον l
    
    % Υπολογισμός για f1
    a = a_init; b = b_init; count = 0; % Reset for each function
    while (b - a) > l
        x1k = (a + b) / 2 - epsilon;
        x2k = (a + b) / 2 + epsilon;
        
        f1k = f1(x1k);
        f2k = f1(x2k);
        count = count + 2; % Αύξηση του αριθμού των υπολογισμών
        
        if f1k < f2k
            b = x2k; % Ενημέρωση ορίων
        else
            a = x1k;
        end
    end
    num_calculations_f1(i) = count; % Αποθήκευση υπολογισμών για f1
    
    % Υπολογισμός για f2
    a = a_init; b = b_init; count = 0; % Reset for each function
    while (b - a) > l
        x1k = (a + b) / 2 - epsilon;
        x2k = (a + b) / 2 + epsilon;
        
        f1k = f2(x1k);
        f2k = f2(x2k);
        count = count + 2; % Αύξηση του αριθμού των υπολογισμών
        
        if f1k < f2k
            b = x2k; % Ενημέρωση ορίων
        else
            a = x1k;
        end
    end
    num_calculations_f2(i) = count; % Αποθήκευση υπολογισμών για f2
    
    % Υπολογισμός για f3
    a = a_init; b = b_init; count = 0; % Reset for each function
    while (b - a) > l
        x1k = (a + b) / 2 - epsilon;
        x2k = (a + b) / 2 + epsilon;
        
        f1k = f3(x1k);
        f2k = f3(x2k);
        count = count + 2; % Αύξηση του αριθμού των υπολογισμών
        
        if f1k < f2k
            b = x2k; % Ενημέρωση ορίων
        else
            a = x1k;
        end
    end
    num_calculations_f3(i) = count; % Αποθήκευση υπολογισμών για f3
end

% Γραφική παράσταση των υπολογισμών για τις τρεις συναρτήσεις
figure;
hold on;
plot(l_values, num_calculations_f1, '-o', 'DisplayName', 'f1(x)');
plot(l_values, num_calculations_f2, '-o', 'DisplayName', 'f2(x)');
plot(l_values, num_calculations_f3, '-o', 'DisplayName', 'f3(x)');
xlabel('l');
ylabel('Total function evaluations');
title('Total number of function evaluations vs l for f1, f2, and f3');
legend show; % Εμφάνιση του λεξικού
grid on;
hold off;