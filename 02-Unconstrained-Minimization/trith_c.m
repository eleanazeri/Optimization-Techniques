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
% Υλοποίηση της μεθόδου Newton με τον κανόνα Armijo
epsilon = 1e-6; % Όριο σύγκλισης
max_iter = 500; % Μέγιστος αριθμός επαναλήψεων
% Ανοίγουμε το διάγραμμα
figure;
hold on;
% Σταθερές για τον κανόνα Armijo
alpha = 0.1; % Σταθερά για τον κανόνα Armijo
beta = 0.7; % Σταθερά για την προσαρμογή του βήματος
% Σημεία για τα ελάχιστα και τις τιμές
min_points = [];
min_f_values = [];
% Ενεργοποίηση των σημείων εκκίνησης για το legend
plot_handles = [];
for i = 1:size(initial_points, 1)
    x = initial_points(i, :)';
    f_values = []; % Για να αποθηκεύσουμε τις τιμές της συνάρτησης κατά την πορεία
    converged = false; % Έλεγχος αν συγκλίνουμε
    for k = 1:max_iter
        grad = grad_f(x); % Υπολογισμός του gradient
        H = hessian_f(x); % Υπολογισμός του Hessian
        
        % Υπολογισμός του βήματος Newton: d = -H^-1 * grad
        d = -inv(H) * grad;
        
        % Υπολογισμός του βήματος γ βάσει του κανόνα Armijo
        gamma = 1; % Αρχική τιμή του γ
        while f(x + gamma * d) > f(x) + alpha * gamma * grad' * d
            gamma = beta * gamma; % Μείωση του βήματος γ
        end
        
        % Ενημερώνουμε την τιμή του x με το βήμα γ
        x = x + gamma * d;
        
        % Αποθηκεύουμε την τιμή της συνάρτησης για σύγκριση
        f_values = [f_values; f(x)];
        
        % Έλεγχος σύγκλισης
        if norm(grad) < epsilon
            converged = true; % Αν συγκλίνει
            % Αποθήκευση του σημείου του ελάχιστου και της τιμής της συνάρτησης
            min_points = [min_points; x'];
            min_f_values = [min_f_values; f(x)];
            % Εκτύπωση σύγκλισης και αριθμού επαναλήψεων στην κονσόλα
            fprintf('Μέθοδος Newton με Armijo: Αρχικό σημείο: (%f, %f), Σύγκλιση σε (%f, %f) σε %d επαναλήψεις.\n', ...
                initial_points(i, 1), initial_points(i, 2), x(1), x(2), k);
            break; % Σταματάμε αν συγκλίνει
        end
    end
    
    if ~converged
        fprintf('Μέθοδος Newton με Armijo: Αρχικό σημείο: (%f, %f) ΔΕΝ συγκλίνει εντός των %d επαναλήψεων.\n', ...
            initial_points(i, 1), initial_points(i, 2), max_iter);
    end
    
    % Εμφανίζουμε τη σύγκλιση της συνάρτησης στο διάγραμμα
    h = plot(1:length(f_values), f_values, 'DisplayName', sprintf('Σύγκλιση από (%f, %f)', initial_points(i, 1), initial_points(i, 2)));
    plot_handles = [plot_handles, h]; % Καταγραφή του handle για το legend
end
% Εμφάνιση των σημείων του τοπικού ελαχίστου
for i = 1:size(min_points, 1)
    plot(i, min_f_values(i), 'ro', 'MarkerFaceColor', 'r'); % Κόκκινο σημείο για το τοπικό ελάχιστο
    text(i, min_f_values(i), sprintf('Min at (%.2f, %.2f)', min_points(i, 1), min_points(i, 2)), ...
         'Color', 'r', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
end
xlabel('Αριθμός Επαναλήψεων');
ylabel('Τιμή της Συνάρτησης f(x, y)');
title('Σύγκλιση Συνάρτησης με Μέθοδο Newton και Κανόνα Armijo');
% Ενημέρωση του legend χωρίς να εμφανίζονται περιττά σημεία
legend(plot_handles, 'Location', 'best');
axis tight; % Αυτό διασφαλίζει ότι όλα τα σημεία θα εμφανίζονται στο διάγραμμα
grid on;
hold off;