% Ορισμός των συναρτήσεων f1, f2, f3
f1 = @(x) (x - 2).^2 + x .* log(x + 3); % f1(x) = (x - 2)^2 + x * ln(x + 3)
f2 = @(x) exp(-2*x) + (x - 2).^2; % f2(x) = e^(-2x) + (x - 2)^2
f3 = @(x) exp(x) .* (x.^3 - 1) + (x - 1) .* sin(x); % f3(x) = e^x * (x^3 - 1) + (x - 1) * sin(x)

% Αρχικό διάστημα [a, b]
a_init = -1;
b_init = 3;

% Σταθερό τελικό εύρος αναζήτησης
l = 0.01;

% Εύρος τιμών για το epsilon
epsilon_values = [0.0001, 0.0005, 0.001]; % Οι ζητούμενες τιμές
num_calculations = zeros(3, length(epsilon_values)); % Μηδενισμός πίνακα για τρεις συναρτήσεις

% Βρόχος για διαφορετικές τιμές του epsilon και τις τρεις συναρτήσεις
for i = 1:3
    % Επιλογή της σωστής συνάρτησης
    if i == 1
        f = f1; % Συναρτηση 1
    elseif i == 2
        f = f2; % Συναρτηση 2
    else
        f = f3; % Συναρτηση 3
    end
    
    for j = 1:length(epsilon_values)
        epsilon = epsilon_values(j);
        a = a_init;
        b = b_init;
        count = 0; % Μετρητής υπολογισμών
        
        % Μέθοδος Διχοτόμου
        while (b - a) > l
            % Υπολογισμός x1k και x2k
            x1k = (a + b) / 2 - epsilon;
            x2k = (a + b) / 2 + epsilon;
            
            % Υπολογισμός των τιμών της f(x)
            f1k = f(x1k);
            f2k = f(x2k);
            count = count + 2; % Αύξηση του αριθμού των υπολογισμών
            
            % Σύγκριση των τιμών f(x1k) και f(x2k)
            if f1k < f2k
                % Αν f(x1k) είναι μικρότερο, ενημερώνουμε τα όρια
                b = x2k; % Το ελάχιστο βρίσκεται στο διάστημα [a, x2k]
            else
                a = x1k; % Το ελάχιστο βρίσκεται στο διάστημα [x1k, b]
            end
        end
        
        % Αποθήκευση του συνολικού αριθμού υπολογισμών
        num_calculations(i, j) = count;
    end
end

% Γραφική παράσταση του αριθμού υπολογισμών σε συνάρτηση του epsilon
figure;
hold on; % Διατήρηση γραφήματος
plot(epsilon_values, num_calculations(1, :), '-o', 'DisplayName', 'f(x) = (x - 2)^2 + x * ln(x + 3)');
plot(epsilon_values, num_calculations(2, :), '-o', 'DisplayName', 'f(x) = e^{-2x} + (x - 2)^2');
plot(epsilon_values, num_calculations(3, :), '-o', 'DisplayName', 'f(x) = e^x * (x^3 - 1) + (x - 1) * sin(x)');
hold off;

xlabel('\epsilon');
ylabel('Total function evaluations');
title('Total number of function evaluations vs \epsilon for multiple functions');
legend('show');
grid on;