# Optimization Techniques

**Aristotle University of Thessaloniki (AUTH)**  
Department of Electrical and Computer Engineering  
Course: Optimization Techniques

---

## Overview

This repository contains MATLAB implementations of classical numerical optimization methods, developed as coursework for the Optimization Techniques course at AUTH ECE. The scope spans single-variable interval reduction, gradient-based unconstrained minimization, constrained projection methods, and population-based evolutionary search. Each module is self-contained and accompanied by a formal technical report.

---

## Module 1 — 1D Search Methods

### Project Overview

This module implements and benchmarks iterative interval-reduction algorithms for minimizing convex functions of one variable over the bounded interval `[-1, 3]`. The mathematical objective is to quantify computational cost — measured in objective function evaluations — as a function of convergence tolerance `ε` and target final interval length `l`, across three distinct test functions, revealing the trade-off between method sophistication and evaluation efficiency.

### Algorithmic Pipeline

1. Define three convex objective functions over the search interval `[-1, 3]`.
2. Implement four search strategies: Bisection, Golden Section, Fibonacci, and Derivative-based Bisection.
3. For each method, sweep `ε` and record the number of function evaluations required to converge.
4. For each method, sweep the target final interval length `l` and record the corresponding evaluation counts.
5. Track and plot the interval endpoint sequence `[a_k, b_k]` across iterations `k` for each function and method.
6. Compare results across all methods to quantify efficiency trade-offs.

### Tech Stack

- **MATLAB** — loop-based algorithm implementation, function evaluation counting, and 2D plotting of convergence metrics across parameter sweeps.

### Implementation Highlights

The module is structured parametrically to isolate each experimental variable independently: scripts are categorized first by search method, then by study type — evaluation count as a function of `ε`, evaluation count as a function of target interval length `l`, and endpoint trajectory plots per test function. This separation ensures that varying tolerance and varying interval length are never conflated in the same execution context, enabling clean cross-method comparison without shared computational state.

---

## Module 2 — Unconstrained Minimization

### Project Overview

This module addresses the minimization of the multimodal, non-convex function `f(x,y) = x⁵ · e^(-x² - y²)`, which exhibits multiple local extrema and a saddle point structure in the 2D search landscape. Three gradient-based solvers — Steepest Descent, Newton's Method, and Levenberg-Marquardt — are implemented and benchmarked under three distinct step-size selection strategies, with particular attention to numerical handling of negative-definite and singular Hessians that arise during Newton iterations near non-convex regions.

### Algorithmic Pipeline

1. Analytically derive and implement the gradient vector and Hessian matrix of the objective function.
2. Visualize the 2D search landscape via surface and contour plots to identify critical points structurally.
3. Implement three solvers: Steepest Descent, Newton's Method, and Levenberg-Marquardt.
4. For each solver, apply three step-size strategies: constant step `γ`, exact line search (minimization of `f(x_k + γ_k d_k)`), and the Armijo backtracking rule.
5. Execute each solver from multiple starting points; record iteration counts, convergence trajectories, and final function values.
6. Compare convergence speed, stability, and behavior near ill-conditioned Hessian regions across all solver–strategy combinations.

### Tech Stack

- **MATLAB** — numerical differentiation, matrix inversion and regularization, iterative solver loops, convergence plotting, and multi-configuration benchmarking.

### Implementation Highlights

The architecture isolates each solver–strategy combination into a self-contained script with no shared state across configurations, allowing any single combination to be executed, profiled, or modified independently without side effects on the remaining configurations. A dedicated visualization script for the objective function surface and contour plots is decoupled from all solver scripts, ensuring that the analytical characterization of the search landscape is reproducible independently of any particular solver run.

---

## Module 3 — Projected Gradient Method

### Project Overview

This module solves a constrained minimization problem over a convex quadratic objective function using the Projected Steepest Descent method. The feasible set is defined by a system of linear inequality constraints, and at each iteration the unconstrained gradient step is projected back onto the feasible region. The study systematically varies the step-size parameter `γ` across theoretically meaningful thresholds to demonstrate the stability bounds derived analytically, and to observe the onset of oscillatory and divergent behavior when those bounds are exceeded.

### Algorithmic Pipeline

1. Define the constrained quadratic optimization problem and characterize the feasible set via its linear inequality representation.
2. Implement unconstrained Steepest Descent as a baseline convergence reference.
3. Implement the Projected Gradient update: `x_{k+1} = P[x_k − γ ∇f(x_k)]`, where `P[·]` denotes Euclidean projection onto the feasible set.
4. Derive theoretical bounds on the step-size parameter `γ` for guaranteed convergence.
5. Execute the projected algorithm for three distinct values of `γ`, recording convergence trajectories and iteration counts for each.
6. Analyze stable versus oscillatory or divergent behavior in relation to the theoretical stability bounds.

### Tech Stack

- **MATLAB** — quadratic form evaluation, gradient computation, iterative projection loop, and convergence trajectory visualization.

### Implementation Highlights

The module is structured parametrically around the step-size parameter `γ`, with each experimental configuration encoded in an independent script so that the effect of that single variable on projected-gradient stability is directly observable in isolation. This design makes the transition from convergent to oscillatory to divergent regimes immediately reproducible by running scripts sequentially, without any inter-script dependency or shared workspace state that could obscure the causal relationship between the projection step magnitude and algorithmic behavior.

---

## Module 4 — Genetic Algorithms for Traffic Flow Optimization

### Project Overview

This module applies a Genetic Algorithm to minimize total vehicle traversal time across a directed road network of 17 links, subject to link capacity constraints and flow conservation equations at each node. The fitness function encodes network travel time as a nonlinear function of the flow distribution vector, and the optimizer must satisfy both equality constraints (flow conservation) and inequality constraints (capacity bounds) simultaneously. The model is evaluated under a nominal demand scenario and under a demand uncertainty sweep to characterize sensitivity of the optimal flow distribution to changes in incoming traffic volume.

### Algorithmic Pipeline

1. Model the road network as a directed graph; define the flow conservation equations and link capacity constraints in matrix form.
2. Formulate the fitness function as total vehicle traversal time expressed as a function of the flow vector.
3. Configure the GA operator parameters: Roulette Wheel selection, 80% crossover rate, 1% mutation rate.
4. Run the GA solver for the nominal demand scenario (`V = 100`); record the optimal flow distribution and minimum total travel time.
5. Sweep the incoming vehicle rate from `V = 85` to `V = 115`; re-run the GA at each demand level.
6. Analyze and plot the evolution of optimal cost and flow distribution under varying demand to identify network congestion thresholds.

### Tech Stack

- **MATLAB** — network constraint formulation, fitness function implementation, result post-processing, and visualization.
- **MATLAB Global Optimization Toolbox** — provides the `ga()` solver used for population-based evolutionary search; required for Genetic Algorithm execution.

### Implementation Highlights

Constraint matrices encoding flow conservation equalities and capacity bound inequalities are constructed programmatically within each script and passed directly to `ga()`, rather than stored as external data files or shared global state. The nominal scenario and the demand sweep are implemented as separate, self-contained scripts so that the constraint-building logic for each case is co-located with its solver configuration, making the mapping from network topology to optimization problem fully traceable within a single readable file per experimental condition.

---

## How to Run

**Prerequisites:** MATLAB R2020a or later. Module 4 additionally requires the Global Optimization Toolbox.

**1. Clone the repository**
```bash
git clone https://github.com/eleanazeri/Optimization-Techniques.git
cd Optimization-Techniques
```

**2. Navigate to the module of interest**
```bash
cd 01-1D-Search-Methods
```

**3. Execute a script in the MATLAB Command Window**
```matlab
cd('path/to/01-1D-Search-Methods')
run('bisection_evals_vs_epsilon.m')
```

Each module is self-contained. Refer to the inline comments within each script for parameter configuration, stopping criteria, and expected outputs.

---

## License

This repository is intended for academic reference. All work is original unless otherwise cited within the accompanying technical reports.
