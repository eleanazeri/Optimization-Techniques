% Ορισμός της συνάρτησης f1
f1 = @(x) (x - 2).^2 + x .* log(x + 3); % f1(x) = (x - 2)^2 + x * ln(x + 3)

% Αρχικό διάστημα [a, b]
a_init = -1;
b_init = 3;

% Σταθερή τιμή epsilon
epsilon = 0.001;

% Διαφορετικές τιμές για το l
l_values = [0.01, 0.05, 0.1, 0.2, 0.5]; % Οι ζητούμενες τιμές του l

% Πίνακες για αποθήκευση των ορίων a_k και b_k
a_values_f1 = cell(size(l_values)); % Cell array για a_k
b_values_f1 = cell(size(l_values)); % Cell array για b_k

% Βρόχος για διαφορετικές τιμές του l
for i = 1:length(l_values)
    l = l_values(i); % Επιλέγουμε το τρέχον l
    a = a_init;  % Επαναφορά του a στο αρχικό -1
    b = b_init;  % Επαναφορά του b στο αρχικό 3
    count = 0; % Reset για κάθε συνάρτηση
    k = 1; % Αρχικοποίηση του k
    a_k = []; % Δημιουργία πίνακα για a_k
    b_k = []; % Δημιουργία πίνακα για b_k
    
    % Αποθήκευση των αρχικών τιμών του a και του b
    a_k = [a_k; a]; %#ok<AGROW>
    b_k = [b_k; b]; %#ok<AGROW>
    
    % Βρόχος διχοτόμησης
    while (b - a) > l
        % Υπολογισμός των x1k και x2k
        x1k = (a + b) / 2 - epsilon;
        x2k = (a + b) / 2 + epsilon;
        
        % Υπολογισμός των τιμών της συνάρτησης στα σημεία x1k και x2k
        f1k = f1(x1k);
        f2k = f1(x2k);
        count = count + 2; % Αύξηση του αριθμού των υπολογισμών
        
        % Ενημέρωση ορίων με βάση τις τιμές της συνάρτησης
        if f1k < f2k
            b = x2k;
        else
            a = x1k;
        end
        
        % Εμφάνιση των τρεχουσών τιμών για διαγνωστικούς σκοπούς
        disp(['Iteration: ', num2str(k), ' a: ', num2str(a), ' b: ', num2str(b)]);
        disp(['x1k: ', num2str(x1k), ' x2k: ', num2str(x2k)]);
        disp(['f1(x1k): ', num2str(f1k), ' f1(x2k): ', num2str(f2k)]);
        
        % Αποθήκευση των τρεχουσών τιμών a και b
        a_k = [a_k; a]; %#ok<AGROW>
        b_k = [b_k; b]; %#ok<AGROW>
        k = k + 1; % Αύξηση του k
    end
    % Αποθήκευση των τελικών τιμών a_k και b_k
    a_values_f1{i} = a_k; % Αποθήκευση των τιμών a_k
    b_values_f1{i} = b_k; % Αποθήκευση των τιμών b_k
end

% Γραφική παράσταση των ορίων για f1
figure;
hold on;
for i = 1:length(l_values)
    k = 1:length(a_values_f1{i});
    plot(k, a_values_f1{i}, '-o', 'DisplayName', sprintf('l = %.2f, a_k', l_values(i)));
    plot(k, b_values_f1{i}, '-x', 'DisplayName', sprintf('l = %.2f, b_k', l_values(i)));
end
xlabel('Iteration (k)');
ylabel('Interval Limits');
title('Limits a_k and b_k for f1(x) vs k');
legend show;
grid on;
hold off;