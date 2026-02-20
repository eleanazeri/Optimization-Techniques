%% Γενετικός Αλγόριθμος για Ελαχιστοποίηση Συνολικού Χρόνου Διάσχισης Δικτύου

clear; clc;
rng(0); 

%% Παράμετροι του προβλήματος
num_roads = 17; % Αριθμός δρόμων
c = [54.13, 21.56, 34.08, 49.19, 33.03, 21.84, 29.96, 24.87, 47.24, 33.97, 26.89, 32.76, 39.98, 37.12, 53.83, 61.65, 59.73 ]; % Χωρητικότητα κάθε δρόμου 
t = 1; % Σταθερός χρόνος διάσχισης

a = [1.25 * ones(1, 5), 1.5 * ones(1, 5), ones(1, 7)]; % Συντελεστές a ανά ομάδα δρόμων

%% Παράμετροι Γενετικού Αλγορίθμου
pop_size = 100; % Μέγεθος πληθυσμού
num_generations = 200; % Αριθμός γενεών
mutation_rate = 0.01; % Ρυθμός μετάλλαξης
crossover_rate = 0.8; % Ρυθμός διασταύρωσης

%% Διαφορετικές τιμές V
V_values = 85:5:115; % Τιμές του V (από 85 έως 115 με βήμα 5)
best_fitness_values = zeros(size(V_values));
best_solutions = zeros(length(V_values), num_roads);

%% Βρόχος για κάθε τιμή του V
for v_idx = 1:length(V_values)
    V = V_values(v_idx);

    %% Αρχικοποίηση πληθυσμού
    population = zeros(pop_size, num_roads);
    for i = 1:pop_size
        x_i = rand(1, num_roads) .* c; % Τυχαίες τιμές στο [0, c_i]
        x_i = x_i / sum(x_i) * V; % Κανονικοποίηση για συνολικό V
        population(i, :) = x_i;
    end

    %% Συνάρτηση Fitness
    fitness = zeros(pop_size, 1);
    for i = 1:pop_size
        fitness(i) = calculate_fitness(population(i, :), t, a, c);
    end

    %% Γενετικός Αλγόριθμος
    for gen = 1:num_generations
        selected_population = selection_roulette(population, fitness);
        new_population = crossover(selected_population, crossover_rate);
        new_population = mutation(new_population, mutation_rate, c);

        for i = 1:pop_size
            fitness(i) = calculate_fitness(new_population(i, :), t, a, c);
        end

        population = new_population;
        [best_fitness(gen), idx] = min(fitness);
        best_solution(gen, :) = population(idx, :);
    end

    %% Αποθήκευση αποτελεσμάτων για κάθε V
    [final_fitness, best_idx] = min(best_fitness);
    best_fitness_values(v_idx) = final_fitness;
    best_solutions(v_idx, :) = best_solution(best_idx, :);
end

%% Αποτελέσματα
fprintf('Αποτελέσματα για διαφορετικές τιμές V:\n');
for v_idx = 1:length(V_values)
    fprintf('V = %d: Ελάχιστος Χρόνος = %.4f\n', V_values(v_idx), best_fitness_values(v_idx));
end

%% Γραφήματα
% Γράφημα Fitness για διαφορετικά V
figure;
plot(V_values, best_fitness_values, '-o', 'LineWidth', 2);
xlabel('Ρυθμός Εισερχομένων Οχημάτων (V)');
ylabel('Ελάχιστος Χρόνος (Fitness)');
title('Επίδραση του V στον Ελάχιστο Χρόνο');
grid on;

% Γράφημα Κατανομής Ροών για τη Μέγιστη και Ελάχιστη Τιμή του V
[min_fitness, min_idx] = min(best_fitness_values);
[max_fitness, max_idx] = max(best_fitness_values);

figure;
subplot(2, 1, 1);
bar(best_solutions(min_idx, :), 'FaceColor', [0.2 0.6 0.8]);
xlabel('Δρόμοι');
ylabel('Ροές Οχημάτων (x_i)');
title(sprintf('Κατανομή Ροών για V = %d (Ελάχιστο Fitness)', V_values(min_idx)));

grid on;
subplot(2, 1, 2);
bar(best_solutions(max_idx, :), 'FaceColor', [0.8 0.4 0.2]);
xlabel('Δρόμοι');
ylabel('Ροές Οχημάτων (x_i)');
title(sprintf('Κατανομή Ροών για V = %d (Μέγιστο Fitness)', V_values(max_idx)));
grid on;

%% Συνάρτηση Υπολογισμού Fitness
function fitness = calculate_fitness(x, t, a, c)
    fitness = 0;
    for i = 1:length(x)
        if x(i) >= c(i)
            fitness = fitness + inf; % Ποινή για παραβίαση περιορισμού
        else
            fitness = fitness + (t + (a(i) * x(i)) / (1 - x(i) / c(i)));
        end
    end
end

%% Συνάρτηση Επιλογής (Roulette Wheel Selection)
function selected_population = selection_roulette(population, fitness)
    prob = 1 ./ fitness; % Αντίστροφα ανάλογες του fitness
    prob = prob / sum(prob); % Κανονικοποίηση
    cum_prob = cumsum(prob);
    selected_population = zeros(size(population));
    for i = 1:size(population, 1)
        r = rand();
        idx = find(cum_prob >= r, 1);
        selected_population(i, :) = population(idx, :);
    end
end

%% Συνάρτηση Διασταύρωσης (Crossover)
function new_population = crossover(population, rate)
    new_population = population;
    for i = 1:2:size(population, 1)
        if rand() < rate && i + 1 <= size(population, 1)
            point = randi(size(population, 2));
            new_population(i, point:end) = population(i+1, point:end);
            new_population(i+1, point:end) = population(i, point:end);
        end
    end
end

%% Συνάρτηση Μετάλλαξης (Mutation)
function mutated_population = mutation(population, rate, c)
    mutated_population = population;
    for i = 1:size(population, 1)
        for j = 1:size(population, 2)
            if rand() < rate
                mutated_population(i, j) = rand() * c(j); % Τυχαία τιμή στο [0, c_j]
            end
        end
    end
end
