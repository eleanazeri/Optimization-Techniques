% Ορισμός των συναρτήσεων f1, f2, f3
f1 = @(x) (x - 2).^2 + x .* log(x + 3); % f1(x) = (x - 2)^2 + x * ln(x + 3)
f2 = @(x) exp(-2*x) + (x - 2).^2; % f2(x) = e^(-2x) + (x - 2)^2
f3 = @(x) exp(x) .* (x.^3 - 1) + (x - 1) .* sin(x); % f3(x) = e^x * (x^3 - 1) + (x - 1) * sin(x)


% Αρχικές τιμές
a_init = -1; % Αρχική τιμή a
b_init = 3;  % Αρχική τιμή b
l_values = [0.01, 0.05, 0.1, 0.2, 0.5]; % Διάφορες τιμές ακρίβειας l
epsilon = 1e-5; % Μικρή σταθερά για το τελευταίο βήμα της μεθόδου

% Προετοιμασία πινάκων για αποθήκευση αριθμού υπολογισμών για κάθε συνάρτηση
num_calculations_f1 = zeros(size(l_values));
num_calculations_f2 = zeros(size(l_values));
num_calculations_f3 = zeros(size(l_values));

% Συνάρτηση για τον υπολογισμό του όρου Fibonacci
fib = @(n) round((((1 + sqrt(5)) / 2)^n - ((1 - sqrt(5)) / 2)^n) / sqrt(5));

% Επανάληψη για κάθε συνάρτηση
for func_idx = 1:3
    % Επιλογή της αντίστοιχης συνάρτησης f
    switch func_idx
        case 1
            f = f1;
            num_calculations = num_calculations_f1;
        case 2
            f = f2;
            num_calculations = num_calculations_f2;
        case 3
            f = f3;
            num_calculations = num_calculations_f3;
    end
    
    % Επανάληψη για κάθε τιμή του l
    for l_idx = 1:length(l_values)
        l = l_values(l_idx);
        a = a_init;
        b = b_init;
        
        % Υπολογισμός του ελάχιστου όρου Fibonacci n που απαιτείται ώστε F_n > (b - a) / l
        n = 1;
        while fib(n) <= (b - a) / l
            n = n + 1;
        end
        
        % Αρχικοποίηση x1 και x2 σύμφωνα με τη μέθοδο Fibonacci
        x1 = a + fib(n - 2) / fib(n) * (b - a);
        x2 = a + fib(n - 1) / fib(n) * (b - a);
        f1k = f(x1);
        f2k = f(x2);
        k = 1;
        count = 2; % Αρχικοί υπολογισμοί της f(x) στα x1 και x2
        
        % Μέθοδος Fibonacci
        while k < n - 2
            if f1k > f2k
                a = x1;
                x1 = x2;
                x2 = a + fib(n - k - 1) / fib(n - k) * (b - a);
                f1k = f2k;
                f2k = f(x2);
            else
                b = x2;
                x2 = x1;
                x1 = a + fib(n - k - 2) / fib(n - k) * (b - a);
                f2k = f1k;
                f1k = f(x1);
            end
            count = count + 1;
            k = k + 1;
        end
        
        % Τελικό βήμα
        x1 = x1;
        x2 = x1 + epsilon;
        if f(x1) > f(x2)
            a = x1;
            b = b;
        else
            a = a;
            b = x1;
        end
        
        % Καταγραφή του συνολικού αριθμού υπολογισμών
        num_calculations(l_idx) = count + 1;
    end
    
    % Αποθήκευση των αποτελεσμάτων στον αντίστοιχο πίνακα
    switch func_idx
        case 1
            num_calculations_f1 = num_calculations;
        case 2
            num_calculations_f2 = num_calculations;
        case 3
            num_calculations_f3 = num_calculations;
    end
end

% Γραφικές Παραστάσεις του αριθμού υπολογισμών για κάθε συνάρτηση
figure;
plot(l_values, num_calculations_f1, '-o', 'DisplayName', 'f1(x)');
hold on;
plot(l_values, num_calculations_f2, '-x', 'DisplayName', 'f2(x)');
plot(l_values, num_calculations_f3, '-s', 'DisplayName', 'f3(x)');
xlabel('Τελικό Εύρος Αναζήτησης (l)');
ylabel('Συνολικός Αριθμός Υπολογισμών f(x)');
title('Συνολικός Αριθμός Υπολογισμών f(x) σε σχέση με το τελικό εύρος αναζήτησης l');
legend show;
grid on;
hold off;
