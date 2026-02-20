# Optimization Techniques

Coursework repository for the **Optimization Techniques** course —
Electrical and Computer Engineering Department, Aristotle University of Thessaloniki (AUTH).

---

## Overview

This repository contains MATLAB implementations and technical reports for the Optimization Techniques course at AUTH ECE. It covers classical numerical optimization methods across four assignments, ranging from single-variable search techniques to derivative-based multivariable solvers, constrained methods, and evolutionary algorithms.

---

## Repository Structure & Contents

```
.
├── 01-1D-Search-Methods/
│   ├── 01-Bisection-Method/
│   │   ├── bisection_evals_vs_epsilon.m
│   │   ├── bisection_evals_vs_l.m
│   │   ├── bisection_endpoints_f1.m
│   │   ├── bisection_endpoints_f2.m
│   │   └── bisection_endpoints_f3.m
│   ├── 02-Golden-Section/
│   │   ├── golden_evals_vs_l.m
│   │   ├── golden_endpoints_f1.m
│   │   ├── golden_endpoints_f2.m
│   │   └── golden_endpoints_f3.m
│   ├── 03-Fibonacci-Method/
│   │   ├── fibonacci_evals_vs_l.m
│   │   ├── fibonacci_endpoints_f1.m
│   │   ├── fibonacci_endpoints_f2.m
│   │   └── fibonacci_endpoints_f3.m
│   ├── 04-Bisection-Derivative/
│   │   ├── bisection_deriv_evals_vs_l.m
│   │   ├── bisection_deriv_endpoints_f1.m
│   │   ├── bisection_deriv_endpoints_f2.m
│   │   └── bisection_deriv_endpoints_f3.m
│   └── Report_Assignment1.pdf
├── 02-Unconstrained-Minimization/
│   ├── plot_objective_function.m
│   ├── steepest_descent_constant_step.m
│   ├── steepest_descent_exact_line_search.m
│   ├── steepest_descent_armijo.m
│   ├── newton_constant_step.m
│   ├── newton_exact_line_search.m
│   ├── newton_armijo.m
│   ├── levenberg_marquardt_constant_step.m
│   ├── levenberg_marquardt_exact_line_search.m
│   ├── levenberg_marquardt_armijo.m
│   └── Report_Assignment2.pdf
├── 03-Projected-Gradient-Method/
│   ├── steepest_descent_unconstrained.m
│   ├── projected_gradient_sk5.m
│   ├── projected_gradient_sk1.m
│   ├── projected_gradient_sk01.m
│   └── Report_Assignment3.pdf
└── 04-Genetic-Algorithms-Traffic-Flow/
    ├── ga_traffic_flow_nominal.m
    ├── ga_traffic_flow_varying_demand.m
    └── Report_Project.pdf
```

### `01-1D-Search-Methods/` — Single-Variable Minimization via Interval Search Methods
Minimization of convex functions of one variable over a bounded interval, without and with the use of derivatives. Systematic comparison of convergence behavior across methods and tolerance settings. Scripts are organized into four subfolders by method.

- **`01-Bisection-Method/`** — `bisection_evals_vs_epsilon.m`, `bisection_evals_vs_l.m`, `bisection_endpoints_f{1,2,3}.m`
- **`02-Golden-Section/`** — `golden_evals_vs_l.m`, `golden_endpoints_f{1,2,3}.m`
- **`03-Fibonacci-Method/`** — `fibonacci_evals_vs_l.m`, `fibonacci_endpoints_f{1,2,3}.m`
- **`04-Bisection-Derivative/`** — `bisection_deriv_evals_vs_l.m`, `bisection_deriv_endpoints_f{1,2,3}.m`

### `02-Unconstrained-Minimization/` — Unconstrained Minimization of Multivariable Functions
Gradient-based minimization of multivariable objective functions using first- and second-order derivative information. Multiple functions and starting points are tested to compare convergence rate, stability, and computational cost across methods. Each method is implemented under three step-size strategies: constant step, exact line search, and Armijo rule.

- `plot_objective_function.m` — visualization of the objective functions
- `steepest_descent_constant_step.m`, `steepest_descent_exact_line_search.m`, `steepest_descent_armijo.m`
- `newton_constant_step.m`, `newton_exact_line_search.m`, `newton_armijo.m`
- `levenberg_marquardt_constant_step.m`, `levenberg_marquardt_exact_line_search.m`, `levenberg_marquardt_armijo.m`

### `03-Projected-Gradient-Method/` — Constrained Optimization via the Projected Gradient Method
Constrained minimization using the Projected Steepest Descent method. Gradient steps are projected onto the feasible set defined by inequality constraints, with analysis of convergence under varying projection step sizes.

- `steepest_descent_unconstrained.m` — baseline unconstrained run for comparison
- `projected_gradient_sk5.m`, `projected_gradient_sk1.m`, `projected_gradient_sk01.m` — projected gradient with $s_k = 5, 1, 0.1$ respectively

### `04-Genetic-Algorithms-Traffic-Flow/` — Network Traffic Flow Minimization via Genetic Algorithms
Application of Genetic Algorithms to minimize total vehicle travel time in a simulated road network subject to link capacity constraints. Two demand scenarios are analyzed.

- `ga_traffic_flow_nominal.m` — optimization under nominal demand ($V = 100$)
- `ga_traffic_flow_varying_demand.m` — sensitivity analysis under varying demand ($\pm 15\%$)

---

## Technologies Used

- **MATLAB** — primary implementation environment
- **MATLAB Optimization Toolbox** — gradient-based solver utilities
- **MATLAB Global Optimization Toolbox** — Genetic Algorithm routines (`ga`)

---

## How to Run

**Prerequisites:** MATLAB R2020a or later, with the Optimization Toolbox and Global Optimization Toolbox installed.

**1. Clone the repository**
```bash
git clone https://github.com/eleanazeri/Optimization-Techniques.git
cd Optimization-Techniques
```

**2. Navigate to the folder of interest**
```bash
cd 02-Unconstrained-Minimization
```

**3. Run the script in MATLAB**

In the MATLAB Command Window:
```matlab
cd('path/to/02-Unconstrained-Minimization')
run('script_name.m')
```

Each folder is self-contained. Refer to inline comments within each `.m` file for parameter configuration and expected outputs.

---

## License

This repository is intended for academic reference. All work is original unless otherwise cited within the technical reports.
