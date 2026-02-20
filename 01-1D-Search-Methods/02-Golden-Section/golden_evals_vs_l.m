% Ορισμός των συναρτήσεων f1, f2, και f3
f1 = @(x) (x - 2).^2 + x .* log(x + 3); 
f2 = @(x) exp(-2*x) + (x - 2).^2;
f3 = @(x) exp(x) .* (x.^3 - 1) + (x - 1) .* sin(x);

% Αρχικές τιμές
a_init = -1; % Αρχική τιμή α
b_init = 3;  % Αρχική τιμή β
l_values = [0.01, 0.05, 0.1, 0.2, 0.5]; % Τιμές για το τελικό εύρος αναζήτησης
gamma = 0.618; % Τιμή του gamma

% Προετοιμασία πινάκων για αποθήκευση των αριθμών υπολογισμών
num_calculations_f1 = []; 
num_calculations_f2 = [];
num_calculations_f3 = [];

% Βρόχος για κάθε τιμή του l
for l = l_values
    % Μέθοδος Χρυσού Τομέα για τη συνάρτηση f1
    a = a_init;
    b = b_init;
    x1k = a + (1 - gamma) * (b - a);
    x2k = a + gamma * (b - a);
    f1k = f1(x1k);
    f2k = f1(x2k);
    count = 2; % Αρχικοί υπολογισμοί της f(x1) και f(x2)
    
    while (b - a) > l
        if f1k > f2k
            a = x1k;
            x1k = x2k;
            x2k = a + gamma * (b - a);
            f1k = f2k;
            f2k = f1(x2k);
        else
            b = x2k;
            x2k = x1k;
            x1k = a + (1 - gamma) * (b - a);
            f2k = f1k;
            f1k = f1(x1k);
        end
        count = count + 1;
    end
    num_calculations_f1 = [num_calculations_f1, count];
    
    % Μέθοδος Χρυσού Τομέα για τη συνάρτηση f2
    a = a_init;
    b = b_init;
    x1k = a + (1 - gamma) * (b - a);
    x2k = a + gamma * (b - a);
    f1k = f2(x1k);
    f2k = f2(x2k);
    count = 2; % Αρχικοί υπολογισμοί της f(x1) και f(x2)
    
    while (b - a) > l
        if f1k > f2k
            a = x1k;
            x1k = x2k;
            x2k = a + gamma * (b - a);
            f1k = f2k;
            f2k = f2(x2k);
        else
            b = x2k;
            x2k = x1k;
            x1k = a + (1 - gamma) * (b - a);
            f2k = f1k;
            f1k = f2(x1k);
        end
        count = count + 1;
    end
    num_calculations_f2 = [num_calculations_f2, count];
    
    % Μέθοδος Χρυσού Τομέα για τη συνάρτηση f3
    a = a_init;
    b = b_init;
    x1k = a + (1 - gamma) * (b - a);
    x2k = a + gamma * (b - a);
    f1k = f3(x1k);
    f2k = f3(x2k);
    count = 2; % Αρχικοί υπολογισμοί της f(x1) και f(x2)
    
    while (b - a) > l
        if f1k > f2k
            a = x1k;
            x1k = x2k;
            x2k = a + gamma * (b - a);
            f1k = f2k;
            f2k = f3(x2k);
        else
            b = x2k;
            x2k = x1k;
            x1k = a + (1 - gamma) * (b - a);
            f2k = f1k;
            f1k = f3(x1k);
        end
        count = count + 1;
    end
    num_calculations_f3 = [num_calculations_f3, count];
end

% Γραφικές παραστάσεις του αριθμού υπολογισμών για τις συναρτήσεις f1, f2, και f3
figure;
plot(l_values, num_calculations_f1, '-o', 'DisplayName', 'f1(x)');
hold on;
plot(l_values, num_calculations_f2, '-x', 'DisplayName', 'f2(x)');
plot(l_values, num_calculations_f3, '-s', 'DisplayName', 'f3(x)');
xlabel('Final Search Range (l)');
ylabel('Total Function Evaluations');
title('Total Function Evaluations vs Final Search Range');
legend;
grid on;
hold off;