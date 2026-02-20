% Ορισμός της συνάρτησης f3 και της παραγώγου της
f3 = @(x) exp(x) .* (x.^3 - 1) + (x - 1) .* sin(x);
df3 = @(x) exp(x) .* (x.^3 - 1) + 3 * x.^2 .* exp(x) + (x - 1) .* cos(x) + sin(x); % Παράγωγος της f3

% Αρχικό διάστημα [a, b] και τιμές l για τη μελέτη
a = -1;
b = 3;
l_values = [0.01, 0.05, 0.1, 0.2, 0.5]; % Διάφορες τιμές ακρίβειας l

% Για κάθε τιμή του l, αποθηκεύουμε τα διαστήματα (α_k, β_k) και τις επαναλήψεις
figure;
for l_idx = 1:length(l_values)
    l = l_values(l_idx);
    alpha = a; % Αρχική τιμή α
    beta = b;  % Αρχική τιμή β
    computations = 0; % Αριθμός υπολογισμών της f3
    
    % Αποθήκευση τιμών των α_k και β_k
    a_vals = [];
    b_vals = [];
    
    % Επαναληπτική διαδικασία διχοτόμου
    while (beta - alpha) > l
        x_k = (alpha + beta) / 2; % Υπολογισμός του x_k
        f_k = f3(x_k); % Υπολογισμός της f3(x_k)
        computations = computations + 1; % Αύξηση του μετρητή υπολογισμών
        
        % Αποθήκευση των άκρων του διαστήματος
        a_vals = [a_vals, alpha];
        b_vals = [b_vals, beta];
        
        % Υπολογισμός της παραγώγου στη θέση x_k
        df_k = df3(x_k); 
        
        if abs(df_k) < 1e-5 % Αν η παράγωγος είναι κοντά στο 0, τερματίζουμε
            break;
        elseif df_k > 0 % Εάν η παράγωγος είναι θετική
            beta = x_k; % Νέο εύρος [α, x_k]
        else % Εάν η παράγωγος είναι αρνητική
            alpha = x_k; % Νέο εύρος [x_k, β]
        end
    end
    
    % Γραφική παράσταση των τιμών (k, a_k) και (k, b_k) για το συγκεκριμένο l
    subplot(ceil(length(l_values)/2), 2, l_idx); % Υποπλοκή για κάθε l
    hold on;
    plot(1:computations, a_vals, '-o', 'DisplayName', 'a_k');
    plot(1:computations, b_vals, '-x', 'DisplayName', 'b_k');
    hold off;
    xlabel('Δείκτης επαναλήψεων k');
    ylabel('Τιμές των a_k και b_k');
    title(['Διάστημα [a_k, b_k] για l = ', num2str(l)]);
    legend;
    grid on;
end
