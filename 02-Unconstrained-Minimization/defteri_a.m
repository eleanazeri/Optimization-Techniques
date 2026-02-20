% Παράμετροι
gamma = 0.1; % Σταθερό βήμα (αρχικά)
tol = 1e-6; % Όριο σύγκλισης
max_iter = 500; % Μέγιστος αριθμός επαναλήψεων
% Αρχικά σημεία
start_points = [0, 0; -1, 1; 1, -1];
% Δημιουργία του διαγράμματος για τη σύγκλιση
figure;
hold on;
% Χρώματα για κάθε αρχικό σημείο
colors = ['b', 'g', 'r'];
% Εξαρτάται από το πόσα διαφορετικά σημεία έχουμε
line_handles = zeros(1, size(start_points, 1)); % Χειριστές γραμμών για το legend
for i = 1:size(start_points, 1)
    x = start_points(i, 1);
    y = start_points(i, 2);
    
    f_values = []; % Για να αποθηκεύσουμε τις τιμές της συνάρτησης κατά την πορεία
    x_values = []; % Για να αποθηκεύσουμε τις συντεταγμένες x
    y_values = []; % Για να αποθηκεύσουμε τις συντεταγμένες y
    
    for iter = 1:max_iter
        % Υπολογισμός gradient
        df_dx = 5 * x^4 * exp(-x^2 - y^2) - 2 * x^6 * exp(-x^2 - y^2);
        df_dy = -2 * x^5 * y * exp(-x^2 - y^2);
        grad_f = [df_dx; df_dy];
        
        % Υπολογισμός τιμής της συνάρτησης f(x, y)
        f_val = x^5 * exp(-x^2 - y^2);
        f_values = [f_values; f_val]; % Αποθήκευση τιμής
        
        % Αποθήκευση των συντεταγμένων x και y
        x_values = [x_values; x];
        y_values = [y_values; y];
        
        % Ενημέρωση θέσης
        x_new = x - gamma * grad_f(1);
        y_new = y - gamma * grad_f(2);
        
        % Έλεγχος σύγκλισης
        if norm([x_new - x, y_new - y]) < tol
            break;
        end
        
        x = x_new;
        y = y_new;
    end
    
    % Εκτύπωση αποτελεσμάτων για κάθε σημείο εκκίνησης
    fprintf('Μέγιστη Κάθοδος: Αρχικό σημείο: (%f, %f), Σύγκλιση σε (%f, %f) σε %d επαναλήψεις.\n', ...
        start_points(i, 1), start_points(i, 2), x, y, iter);
    
    % Σχεδίαση της σύγκλισης της συνάρτησης f(x, y) με συγκεκριμένο χρώμα
    line_handles(i) = plot(1:length(f_values), f_values, colors(i), 'LineWidth', 2);
    
    % Προσθήκη του ελαχίστου σημείου και της αντίστοιχης τιμής της συνάρτησης
    plot(iter, f_values(end), 'ro', 'MarkerFaceColor', 'r'); % Ενδεικτικό σημείο ελαχίστου
    text(iter, f_values(end), sprintf('  (%.2f, %.2f)', x, y), 'FontSize', 8);
end
% Ρυθμίσεις του διαγράμματος
xlabel('Αριθμός Επαναλήψεων');
ylabel('Τιμή της Συνάρτησης f(x, y)');
title('Σύγκλιση της Συνάρτησης με Μέθοδο Μέγιστης Καθόδου και Σταθερό Βήμα');
% Δημιουργία του legend με βάση τους χειριστές γραμμών και τα χρώματα
legend(line_handles, {'Start Point (0, 0)', 'Start Point (-1, 1)', 'Start Point (1, -1)'});
hold off;
