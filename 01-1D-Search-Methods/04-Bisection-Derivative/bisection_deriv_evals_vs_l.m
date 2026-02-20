% Ορισμός των συναρτήσεων και των παραγώγων τους
f1 = @(x) (x - 2).^2 + x .* log(x + 3);
df1 = @(x) 2 * (x - 2) + log(x + 3) + x ./ (x + 3); % Παράγωγος της f1

f2 = @(x) exp(-2*x) + (x - 2).^2;
df2 = @(x) -2 * exp(-2*x) + 2 * (x - 2); % Παράγωγος της f2

f3 = @(x) exp(x) .* (x.^3 - 1) + (x - 1) .* sin(x);
df3 = @(x) exp(x) .* (x.^3 - 1) + exp(x) .* (3 * x.^2) + sin(x) + (x - 1) .* cos(x); % Παράγωγος της f3

% Αρχικό διάστημα [a, b] και τιμές l για τη μελέτη
a = -1;
b = 3;
l_values = [0.01, 0.05, 0.1, 0.2, 0.5]; % Διάφορες τιμές ακρίβειας l

% Πίνακες για να αποθηκεύσουμε τον αριθμό υπολογισμών για κάθε συνάρτηση
results_computations_f1 = zeros(size(l_values));
results_computations_f2 = zeros(size(l_values));
results_computations_f3 = zeros(size(l_values));

% Επανάληψη για κάθε τιμή του l για κάθε συνάρτηση
for l_idx = 1:length(l_values)
    l = l_values(l_idx);
    
    % Μέθοδος Διχοτόμου για f1
    alpha = a;
    beta = b;
    computations = 0;
    while (beta - alpha) > l
        x_k = (alpha + beta) / 2;
        computations = computations + 1;
        df_k = df1(x_k);
        if abs(df_k) < 1e-5
            break;
        elseif df_k > 0
            beta = x_k;
        else
            alpha = x_k;
        end
    end
    results_computations_f1(l_idx) = computations;
    
    % Μέθοδος Διχοτόμου για f2
    alpha = a;
    beta = b;
    computations = 0;
    while (beta - alpha) > l
        x_k = (alpha + beta) / 2;
        computations = computations + 1;
        df_k = df2(x_k);
        if abs(df_k) < 1e-5
            break;
        elseif df_k > 0
            beta = x_k;
        else
            alpha = x_k;
        end
    end
    results_computations_f2(l_idx) = computations;

    % Μέθοδος Διχοτόμου για f3
    alpha = a;
    beta = b;
    computations = 0;
    while (beta - alpha) > l
        x_k = (alpha + beta) / 2;
        computations = computations + 1;
        df_k = df3(x_k);
        if abs(df_k) < 1e-5
            break;
        elseif df_k > 0
            beta = x_k;
        else
            alpha = x_k;
        end
    end
    results_computations_f3(l_idx) = computations;
end

% Γραφικές παραστάσεις
figure;
subplot(3,1,1);
plot(l_values, results_computations_f1, '-o');
xlabel('Τελικό εύρος αναζήτησης l');
ylabel('Υπολογισμοί της f1(x)');
title('Μεταβολή υπολογισμών για τη συνάρτηση f1');
grid on;

subplot(3,1,2);
plot(l_values, results_computations_f2, '-o');
xlabel('Τελικό εύρος αναζήτησης l');
ylabel('Υπολογισμοί της f2(x)');
title('Μεταβολή υπολογισμών για τη συνάρτηση f2');
grid on;

subplot(3,1,3);
plot(l_values, results_computations_f3, '-o');
xlabel('Τελικό εύρος αναζήτησης l');
ylabel('Υπολογισμοί της f3(x)');
title('Μεταβολή υπολογισμών για τη συνάρτηση f3');
grid on;
