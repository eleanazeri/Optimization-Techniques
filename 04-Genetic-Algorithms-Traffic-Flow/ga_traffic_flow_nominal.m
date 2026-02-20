%% Γενετικός Αλγόριθμος για Ελαχιστοποίηση Συνολικού Χρόνου Διάσχισης Δικτύου

clear; clc;
rng(0);

%% Παράμετροι του προβλήματος
num_roads = 17; % Αριθμός δρόμων
V = 100; % Ρυθμός εισερχομένων οχημάτων
c = [54.13, 21.56, 34.08, 49.19, 33.03, 21.84, 29.96, 24.87, 47.24, 33.97, 26.89, 32.76, 39.98, 37.12, 53.83, 61.65, 59.73 ]; % Χωρητικότητα κάθε δρόμου
t = 1; % Σταθερός χρόνος διάσχισης

a = [1.25 * ones(1, 5), 1.5 * ones(1, 5), ones(1, 7)]; % Συντελεστές a ανά ομάδα δρόμων

%% Παράμετροι Γενετικού Αλγορίθμου
pop_size = 100; % Μέγεθος πληθυσμού
num_generations = 200; % Αριθμός γενεών
mutation_rate = 0.01; % Ρυθμός μετάλλαξης
crossover_rate = 0.8; % Ρυθμός διασταύρωσης

%% Αρχικοποίηση πληθυσμού
% Κάθε χρωμόσωμα αναπαριστά μια πιθανή κατανομή των x_i (ροές οχημάτων)
population = zeros(pop_size, num_roads);
for i = 1:pop_size
    % Δημιουργία τυχαίων x_i που ικανοποιούν τους περιορισμούς
    x_i = rand(1, num_roads) .* c; % Τυχαίες τιμές στο [0, c_i]
    % Κανονικοποίηση ώστε να ικανοποιείται ο περιορισμός της συνολικής ροής
    x_i = x_i / sum(x_i) * V;
    population(i, :) = x_i;
end

%% Συνάρτηση Fitness
fitness = zeros(pop_size, 1);
for i = 1:pop_size
    fitness(i) = calculate_fitness(population(i, :), t, a, c);
end

%% Γενετικός Αλγόριθμος
for gen = 1:num_generations
    % Επιλογή (Selection) - Τροχός της τύχης
    selected_population = selection_roulette(population, fitness);

    % Διασταύρωση (Crossover)
    new_population = crossover(selected_population, crossover_rate);

    % Μετάλλαξη (Mutation)
    new_population = mutation(new_population, mutation_rate, c);

    % Υπολογισμός νέου fitness
    for i = 1:pop_size
        fitness(i) = calculate_fitness(new_population(i, :), t, a, c);
    end

    % Ενημέρωση πληθυσμού
    population = new_population;

    % Αποθήκευση καλύτερης λύσης
    [best_fitness(gen), idx] = min(fitness);
    best_solution(gen, :) = population(idx, :);
end

%% Αποτελέσματα
[final_fitness, best_idx] = min(best_fitness);
final_solution = best_solution(best_idx, :);

fprintf('Καλύτερη Λύση: \n');
disp(final_solution);
fprintf('Ελάχιστος Χρόνος: %.4f \n', final_fitness);

%% Γράφημα καλύτερης fitness ανά γενιά
figure;
plot(1:num_generations, best_fitness, '-o', 'LineWidth', 2);
xlabel('Γενιά');
ylabel('Καλύτερη Fitness');
title('Εξέλιξη της Καλύτερης Fitness ανά Γενιά');
grid on;

%% Γράφημα τελικής κατανομής ροών
figure;
bar(final_solution, 'FaceColor', [0.2 0.6 0.8]);
xlabel('Δρόμοι');
ylabel('Ροές Οχημάτων (x_i)');
title('Κατανομή Ροών στη Βέλτιστη Λύση');
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
    % Υπολογισμός πιθανοτήτων επιλογής
    prob = 1 ./ fitness; % Αντίστροφα ανάλογες του fitness
    prob = prob / sum(prob); % Κανονικοποίηση

    % Επιλογή δειγμάτων με βάση τη ρουλέτα
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
            % Επιλογή σημείου διασταύρωσης
            point = randi(size(population, 2));
            % Ανταλλαγή γονιδίων
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
