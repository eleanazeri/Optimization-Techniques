% Ορισμός της συνάρτησης f1
f1 = @(x) (x - 2).^2 + x .* log(x + 3);

% Αρχικές τιμές
a_init = -1; % Αρχική τιμή α
b_init = 3;  % Αρχική τιμή β
l_values = [0.01, 0.05, 0.1, 0.2, 0.5]; % Τιμές για το τελικό εύρος αναζήτησης
gamma = 0.618; % Τιμή του gamma

% Προετοιμασία πινάκων για αποθήκευση των αποτελεσμάτων
results_a_all = {}; % Κελιά για αποθήκευση των a_k για κάθε τιμή του l
results_b_all = {}; % Κελιά για αποθήκευση των b_k για κάθε τιμή του l

% Βρόχος για κάθε τιμή του l
for l_idx = 1:length(l_values)
    l = l_values(l_idx);
    
    % Αρχικοποίηση για τη μέθοδο Χρυσού Τομέα
    a = a_init;
    b = b_init;
    
    % Αρχικοί υπολογισμοί
    x1k = a + (1 - gamma) * (b - a);
    x2k = a + gamma * (b - a);
    f1k = f1(x1k);
    f2k = f1(x2k);
    
    % Αποθήκευση των τιμών α και β σε κάθε επανάληψη
    ak_values = [a];
    bk_values = [b];
    
    % Μέθοδος Χρυσού Τομέα
    while (b - a) > l
        if f1k > f2k
            a = x1k; % Ενημέρωση του a
            x1k = x2k; % Ενημέρωση x1k
            x2k = a + gamma * (b - a); % Νέο x2k
            f1k = f2k; % Ενημέρωση της f(x1k)
            f2k = f1(x2k); % Υπολογισμός f(x2k)
        else
            b = x2k; % Ενημέρωση του b
            x2k = x1k; % Ενημέρωση x2k
            x1k = a + (1 - gamma) * (b - a); % Νέο x1k
            f2k = f1k; % Ενημέρωση της f(x2k)
            f1k = f1(x1k); % Υπολογισμός f(x1k)
        end
        
        % Αποθήκευση των τρεχουσών τιμών a και b
        ak_values = [ak_values, a];
        bk_values = [bk_values, b];
    end
    
    % Αποθήκευση των αποτελεσμάτων για κάθε τιμή του l
    results_a_all{l_idx} = ak_values;
    results_b_all{l_idx} = bk_values;
end

% Γραφικές παραστάσεις των τιμών a_k και b_k σε συνάρτηση με τον δείκτη k
figure;
hold on;
for l_idx = 1:length(l_values)
    ak_values = results_a_all{l_idx};
    bk_values = results_b_all{l_idx};
    k_values = 1:length(ak_values); % Δείκτες επαναλήψεων
    
    % Σχεδίαση των a_k και b_k για κάθε τιμή του l
    plot(k_values, ak_values, '-o', 'DisplayName', ['a_k, l = ', num2str(l_values(l_idx))]);
    plot(k_values, bk_values, '-x', 'DisplayName', ['b_k, l = ', num2str(l_values(l_idx))]);
end
xlabel('Iteration (k)');
ylabel('Values of a_k and b_k');
title('Values of a_k and b_k for f1(x) using Golden Section Search');
legend show;
grid on;
hold off;