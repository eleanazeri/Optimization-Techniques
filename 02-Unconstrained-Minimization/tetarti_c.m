% Ορισμός της συνάρτησης f(x, y) και του gradient
f = @(x) x(1)^5 * exp(-x(1)^2 - x(2)^2); % Συνάρτηση f(x, y)
grad_f = @(x) [5*x(1)^4 * exp(-x(1)^2 - x(2)^2) - 2*x(1)^6 * exp(-x(1)^2 - x(2)^2); ...
               -2*x(1)^5 * x(2) * exp(-x(1)^2 - x(2)^2)]; % Παράγωγος
% Υπολογισμός του Hessian
hessian_f = @(x) [20*x(1)^3 * exp(-x(1)^2 - x(2)^2) - 8*x(1)^5 * exp(-x(1)^2 - x(2)^2) + 4*x(1)^7 * exp(-x(1)^2 - x(2)^2), ...
                  -10*x(1)^4 * x(2) * exp(-x(1)^2 - x(2)^2); ...
                  -10*x(1)^4 * x(2) * exp(-x(1)^2 - x(2)^2), ...
                  -2*x(1)^5 * exp(-x(1)^2 - x(2)^2)]; % Δευτέρες παραγώγοι
% Σημεία εκκίνησης
initial_points = [0, 0; -1, 1; 1, -1];
% Χρώματα για κάθε σημείο εκκίνησης
colors = ['r', 'g', 'b']; % Κόκκινο, Πράσινο, Μπλε
% Ανοίγουμε ένα figure για να δούμε την σύγκλιση
figure;
hold on;
% Παράμετροι της μεθόδου
epsilon = 1e-6; % Όριο σύγκλισης
max_iter = 100000; % Μέγιστος αριθμός επαναλήψεων
alpha = 0.1; % Παράμετρος για τον κανόνα Armijo
lambda = 0.01; % Αρχική τιμή για τη σταθερά απόσβεσης
% Υλοποίηση της μεθόδου Levenberg-Marquardt με Κανόνα Armijo για το βήμα γ
for i = 1:size(initial_points, 1)
    x = initial_points(i, :)';
    f_values = []; % Για να αποθηκεύσουμε τις τιμές της συνάρτησης κατά την πορεία
    local_minima_x = []; % Για να αποθηκεύσουμε τα x των τοπικών ελαχίστων
    local_minima_y = []; % Για να αποθηκεύσουμε τα y των τοπικών ελαχίστων
    local_minima_f = []; % Για να αποθηκεύσουμε τις τιμές της συνάρτησης στα τοπικά ελάχιστα
    
    for k = 1:max_iter
        grad = grad_f(x); % Υπολογισμός του gradient
        hess = hessian_f(x); % Υπολογισμός του Hessian
        d = -(hess + lambda * eye(2)) \ grad; % Κατεύθυνση καθόδου με παράμετρο απόσβεσης
        
        % Εφαρμογή του κανόνα Armijo για την εύρεση του βήματος gamma
        gamma = 1; % Αρχική εκτίμηση για το beta
        while f(x + gamma * d) > f(x) + alpha * gamma * grad' * d
            gamma = gamma / 2; % Μειώνουμε το βήμα
        end
        
        % Ενημερώνουμε την τιμή του x
        x_new = x + gamma * d;
        
        % Προσαρμογή της παραμέτρου lambda
        if f(x_new) < f(x)
            lambda = lambda / 10; % Μείωση του lambda αν βελτιώνεται
        else
            lambda = lambda * 10; % Αύξηση του lambda αν δεν βελτιώνεται
        end
        
        x = x_new; % Ενημέρωση του x
        
        % Αποθηκεύουμε την τιμή της συνάρτησης για σύγκριση
        f_values = [f_values; f(x)];
        
        % Αν η συνάρτηση συγκλίνει (ελάχιστο), αποθηκεύουμε το σημείο
        if norm(grad) < epsilon
            local_minima_x = [local_minima_x; x(1)];
            local_minima_y = [local_minima_y; x(2)];
            local_minima_f = [local_minima_f; f(x)];
            break; % Σταματάμε αν βρούμε το ελάχιστο
        end
    end
    
    % Εμφανίζουμε τη σύγκλιση της συνάρτησης με διαφορετικό χρώμα για κάθε σημείο εκκίνησης
    plot(1:length(f_values), f_values, 'Color', colors(i)); % Χρησιμοποιούμε διαφορετικό χρώμα για κάθε επανάληψη
    
    % Εμφανίζουμε τα τοπικά ελάχιστα ως κόκκινα σημεία στο διάγραμμα
    plot(local_minima_x, local_minima_f, 'ro', 'MarkerFaceColor', colors(i)); % Χρώμα για τα τοπικά ελάχιστα
    
    % Εκτύπωση σύγκλισης
    fprintf('Μέθοδος Levenberg-Marquardt με Armijo: Αρχικό σημείο: (%f, %f), Σύγκλιση σε (%f, %f) σε %d επαναλήψεις.\n', ...
        initial_points(i, 1), initial_points(i, 2), x(1), x(2), k);
end