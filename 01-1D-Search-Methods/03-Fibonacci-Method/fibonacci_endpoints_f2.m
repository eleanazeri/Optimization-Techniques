% Ορισμός της συνάρτησης f2
f2 = @(x) exp(-2*x) + (x - 2).^2;

% Αρχικές τιμές
a_init = -1; % Αρχική τιμή α
b_init = 3;  % Αρχική τιμή β
l_values = [0.01, 0.05, 0.1, 0.2, 0.5]; % Τιμές για το τελικό εύρος αναζήτησης
epsilon = 1e-5; % Μικρή σταθερά για το τελευταίο βήμα της μεθόδου

% Συνάρτηση Fibonacci
fib = @(n) round((((1 + sqrt(5)) / 2)^n - ((1 - sqrt(5)) / 2)^n) / sqrt(5));

% Αποθήκευση αποτελεσμάτων
results_a_f2 = cell(size(l_values)); % Αποθήκευση ακραίων τιμών a_k για κάθε l
results_b_f2 = cell(size(l_values)); % Αποθήκευση ακραίων τιμών b_k για κάθε l

% Επανάληψη για κάθε τιμή του l
for l_idx = 1:length(l_values)
    l = l_values(l_idx);
    a = a_init;
    b = b_init;
    
    % Υπολογισμός του ελάχιστου όρου Fibonacci n για F_n > (b - a) / l
    n = 1;
    while fib(n) <= (b - a) / l
        n = n + 1;
    end
    
    % Αρχικοποίηση των τιμών x1 και x2
    x1 = a + fib(n - 2) / fib(n) * (b - a);
    x2 = a + fib(n - 1) / fib(n) * (b - a);
    f1k = f2(x1); % Υπολογισμός της συνάρτησης f2
    f2k = f2(x2); % Υπολογισμός της συνάρτησης f2
    k = 1;
    
    % Αρχικοποίηση πινάκων για αποθήκευση των ακραίων τιμών
    ak_values = a; % Αρχική τιμή a
    bk_values = b; % Αρχική τιμή b
    
    % Μέθοδος Fibonacci
    while k < n - 2
        if f1k > f2k
            a = x1;
            x1 = x2;
            x2 = a + fib(n - k - 1) / fib(n - k) * (b - a);
            f1k = f2k;
            f2k = f2(x2); % Υπολογισμός της συνάρτησης f2
        else
            b = x2;
            x2 = x1;
            x1 = a + fib(n - k - 2) / fib(n - k) * (b - a);
            f2k = f1k;
            f1k = f2(x1); % Υπολογισμός της συνάρτησης f2
        end
        % Καταγραφή τρεχουσών τιμών a και b
        ak_values = [ak_values, a];
        bk_values = [bk_values, b];
        k = k + 1;
    end
    
    % Τελικό βήμα
    x1 = x1;
    x2 = x1 + epsilon;
    if f2(x1) > f2(x2)
        a = x1;
    else
        b = x1;
    end
    ak_values = [ak_values, a];
    bk_values = [bk_values, b];
    
    % Αποθήκευση των τιμών [a_k, b_k] για το συγκεκριμένο l
    results_a_f2{l_idx} = ak_values;
    results_b_f2{l_idx} = bk_values;
end

% Γραφική Παράσταση των τιμών a_k και b_k για κάθε τιμή του l
figure;
hold on;
for i = 1:length(l_values)
    plot(1:length(results_a_f2{i}), results_a_f2{i}, '-o', 'DisplayName', ['a_k, l = ', num2str(l_values(i))]);
    plot(1:length(results_b_f2{i}), results_b_f2{i}, '-x', 'DisplayName', ['b_k, l = ', num2str(l_values(i))]);
end
xlabel('Δείκτης Επαναλήψεων (k)');
ylabel('Τιμές a_k και b_k');
title('Τιμές a_k και b_k για τη συνάρτηση f2(x) και διάφορα l');
legend show;
grid on;
hold off;
