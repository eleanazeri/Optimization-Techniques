% Δημιουργία πλέγματος x και y
x = linspace(-2, 2, 100); % Τιμές x από -2 έως 2
y = linspace(-2, 2, 100); % Τιμές y από -2 έως 2
[X, Y] = meshgrid(x, y); % Πλέγμα σημείων

% Υπολογισμός της συνάρτησης f(x, y)
Z = X.^5 .* exp(-(X.^2 + Y.^2));

% Πρώτο γράφημα: Surface Plot
figure; % Δημιουργία νέου παραθύρου
surf(X, Y, Z); % Σχεδίαση 3D επιφάνειας
shading interp; % Ομαλή απόδοση χρώματος
colormap('viridis'); % Επιλογή χρωματικής κλίμακας
title('Surface Plot of f(x, y)');
xlabel('x'); ylabel('y'); zlabel('f(x, y)');

% Δεύτερο γράφημα: Contour Plot
figure; % Δημιουργία νέου παραθύρου
contour(X, Y, Z, 20); % Σχεδίαση ισοϋψών καμπυλών
colormap('viridis'); % Επιλογή χρωματικής κλίμακας
colorbar; % Προσθήκη έγχρωμης γραμμής τιμών
title('Contour Plot of f(x, y)');
xlabel('x'); ylabel('y');
