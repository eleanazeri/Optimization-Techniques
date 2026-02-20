% Ορισμός της συνάρτησης f(x, y) και του gradient και Hessian
f = @(x) x(1)^5 * exp(-x(1)^2 - x(2)^2); % Συναρτηση f(x, y)
% Υπολογισμός του gradient (παράγωγοι)
grad_f = @(x) [5*x(1)^4 * exp(-x(1)^2 - x(2)^2) - 2*x(1)^6 * exp(-x(1)^2 - x(2)^2); ...
               -2*x(1)^5 * x(2) * exp(-x(1)^2 - x(2)^2)];
% Υπολογισμός του Hessian (δευτέρες παράγωγοι)
hessian_f = @(x) [20*x(1)^3 * exp(-x(1)^2 - x(2)^2) - 12*x(1)^5 * exp(-x(1)^2 - x(2)^2), ...
                  -10*x(1)^4 * x(2) * exp(-x(1)^2 - x(2)^2);
                  -10*x(1)^4 * x(2) * exp(-x(1)^2 - x(2)^2), ...
                  -2*x(1)^5 * exp(-x(1)^2 - x(2)^2) - 2*x(1)^5 * exp(-x(1)^2 - x(2)^2)];
% Σημεία εκκίνησης
initial_points = [0, 0; -1, 1; 1, -1];
% Υλοποίηση της μεθόδου του Newton με σταθερό βήμα
epsilon = 1e-6; % Όριο σύγκλισης
max_iter = 500; % Μέγιστος αριθμός επαναλήψεων
gamma = 0.1; % Σταθερό βήμα για (α)
% Δημιουργία του διαγράμματος για τη σύγκλιση
figure;
hold on;
% Λίστα για το χρώμα κάθε γραμμής
line_colors = lines(size(initial_points, 1));
for i = 1:size(initial_points, 1)
    x = initial_points(i, :)';
    f_values = []; % Για να αποθηκεύσουμε τις τιμές της συνάρτησης κατά την πορεία
    converged = false; % Έλεγχος αν συγκλίνουμε
    min_point = []; % Για αποθήκευση του σημείου του τοπικού ελάχιστου
    min_f_value = []; % Για αποθήκευση της τιμής της συνάρτησης στο τοπικό ελάχιστο
    
    for k = 1:max_iter
        grad = grad_f(x); % Υπολογισμός του gradient
        H = hessian_f(x); % Υπολογισμός του Hessian
        
        % Υπολογισμός του βήματος Newton: d = -H^-1 * grad
        d = -inv(H) * grad;
        
        % Ενημερώνουμε την τιμή του x με το σταθερό βήμα
        x = x + gamma * d;
        
        % Αποθηκεύουμε την τιμή της συνάρτησης για σύγκριση
        f_values = [f_values; f(x)];
        
        % Έλεγχος σύγκλισης
        if norm(grad) < epsilon
            converged = true; % Αν συγκλίνει
            min_point = x; % Αποθήκευση του σημείου ελάχιστου
            min_f_value = f(x); % Αποθήκευση της τιμής της συνάρτησης στο ελάχιστο
            % Εκτύπωση σύγκλισης και αριθμού επαναλήψεων στην κονσόλα
            fprintf('Μέθοδος Newton με Σταθερό Βήμα: Αρχικό σημείο: (%f, %f), Σύγκλιση σε (%f, %f) σε %d επαναλήψεις.\n', ...
                initial_points(i, 1), initial_points(i, 2), x(1), x(2), k);
            break; % Σταματάμε αν συγκλίνει
        end
    end
    
    if ~converged
        fprintf('Μέθοδος Newton με Σταθερό Βήμα: Αρχικό σημείο: (%f, %f) ΔΕΝ συγκλίνει εντός των %d επαναλήψεων.\n', ...
            initial_points(i, 1), initial_points(i, 2), max_iter);
    end
    
    % Εμφανίζουμε τη σύγκλιση της συνάρτησης στο διάγραμμα
    plot(1:length(f_values), f_values, 'Color', line_colors(i, :)); % Χρήση συγκεκριμένου χρώματος για κάθε γραμμή
    
    % Αν συγκλίνει, εμφανίζουμε το σημείο του ελάχιστου
    if converged
        plot(length(f_values), min_f_value, 'ro', 'MarkerFaceColor', 'r'); % Εμφάνιση του σημείου ελάχιστου
        text(length(f_values), min_f_value, sprintf('  Min at (%.2f, %.2f)', min_point(1), min_point(2)), ...
            'Color', 'r', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
    end
end
% Ρυθμίσεις του διαγράμματος
xlabel('Αριθμός Επαναλήψεων');
ylabel('Τιμή της Συνάρτησης f(x, y)');
title('Σύγκλιση Συνάρτησης με Μέθοδο Newton και Σταθερό Βήμα');
% Εμφάνιση μόνο των χρωμάτων των γραμμών στο legend (χωρίς "data 1", "data 2", "data 3")
legend({'Point (0, 0)', 'Point (-1, 1)', 'Point (1, -1)'}, 'Location', 'best'); % Άδειες ετικέτες στο legend
grid on;
hold off;