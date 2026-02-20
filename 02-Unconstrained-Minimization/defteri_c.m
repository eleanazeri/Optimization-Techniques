% Παράμετροι
alpha = 0.1; % Σταθερά Armijo (συνήθως 0 < alpha < 0.5)
beta = 0.5;  % Παράμετρος για τη μείωση του βήματος
gamma_init = 3; % Αρχική τιμή του βήματος
tol = 1e-6; % Όριο σύγκλισης
max_iter =500; % Μέγιστος αριθμός επαναλήψεων
% Αρχικά σημεία
start_points = [0, 0; -1, 1; 1, -1];
% Δημιουργία του διαγράμματος για την σύγκλιση
figure;
hold on;
% Αποθήκευση των σημείων ελαχίστου για εμφάνιση
min_points = [];
min_values = [];
for i = 1:size(start_points, 1)
    x = start_points(i, 1);
    y = start_points(i, 2);
    
    % Αποθήκευση των τιμών της συνάρτησης για κάθε επανάληψη
    f_values = zeros(max_iter, 1);
    
    converged = false; % Flag για την ένδειξη αν η μέθοδος συγκλίνει
    
    for iter = 1:max_iter
        % Υπολογισμός gradient
        df_dx = 5 * x^4 * exp(-x^2 - y^2) - 2 * x^6 * exp(-x^2 - y^2);
        df_dy = -2 * x^5 * y * exp(-x^2 - y^2);
        grad_f = [df_dx; df_dy];
        
        % Κατεύθυνση (gradient descent)
        d = -grad_f;
        
        % Αρχικό βήμα
        gamma = gamma_init;
        
        % Εφαρμογή του κανόνα Armijo
        while f(x + gamma * d(1), y + gamma * d(2)) > f(x, y) + alpha * gamma * grad_f' * d
            gamma = beta * gamma; % Μείωση του βήματος αν η συνθήκη δεν ικανοποιείται
        end
        
        % Ενημέρωση θέσης
        x_new = x + gamma * d(1);
        y_new = y + gamma * d(2);
        
        % Αποθήκευση της τιμής της συνάρτησης για το διάγραμμα
        f_values(iter) = f(x_new, y_new);
        
        % Έλεγχος σύγκλισης
        if norm([x_new - x, y_new - y]) < tol
            % Αποθήκευση του σημείου ελαχίστου και της τιμής της συνάρτησης
            min_points = [min_points; x_new, y_new];
            min_values = [min_values; f(x_new, y_new)];
            
            % Εκτύπωση σύγκλισης και αριθμού επαναλήψεων στην κονσόλα
            fprintf('Μέθοδος Μέγιστης Καθόδου με Armijo: Αρχικό σημείο: (%f, %f), Σύγκλιση σε (%f, %f) σε %d επαναλήψεις.\n', ...
                start_points(i, 1), start_points(i, 2), x_new, y_new, iter);
            converged = true; % Η μέθοδος συγκλίνει
            break; % Σταματάμε αν συγκλίνει
        end
        
        % Ενημέρωση τιμών
        x = x_new;
        y = y_new;
    end
    
    % Αν δεν συγκλίνει μετά από το μέγιστο αριθμό επαναλήψεων
    if ~converged
        fprintf('Μέθοδος Μέγιστης Καθόδου με Armijo: Αρχικό σημείο: (%f, %f) ΔΕΝ συγκλίνει μετά από %d επαναλήψεις.\n', ...
                start_points(i, 1), start_points(i, 2), max_iter);
    end
    
    % Πλοτ της σύγκλισης της συνάρτησης
    plot(1:iter, f_values(1:iter)); % Αφαίρεσα το DisplayName για να μην εμφανίζονται τα "data"
end
% Σχεδίαση των σημείων ελαχίστου στο διάγραμμα
for i = 1:size(min_points, 1)
    % Σημείο ελαχίστου με κόκκινο χρώμα και σημείο
    plot(1, min_values(i), 'ro', 'MarkerFaceColor', 'r'); % Χωρίς να το προσθέσουμε στο legend
end
% Ρυθμίσεις του διαγράμματος
xlabel('Επαναλήψεις');
ylabel('Τιμή της συνάρτησης f(x, y)');
title('Σύγκλιση της συνάρτησης f με τη μέθοδο Μέγιστης Καθόδου και τον κανόνα Armijo');
% Εμφάνιση μόνο των σημείων εκκίνησης στο legend (χωρίς "data 1", "data 2", "data 3")
legend({'Point (0, 0)', 'Point (-1, 1)', 'Point (1, -1)'}, 'Location', 'best');
grid on;
hold off;
% Συνάρτηση για τον υπολογισμό της τιμής της συνάρτησης f
function val = f(x, y)
    val = x^5 * exp(-x^2 - y^2);
end