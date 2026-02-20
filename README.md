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
├── 02-Unconstrained-Minimization/
├── 03-Projected-Gradient-Method/
└── 04-Genetic-Algorithms-Traffic-Flow/
```

### `01-1D-Search-Methods/` — Single-Variable Minimization via Interval Search Methods
Minimization of convex functions of one variable over a bounded interval, without and with the use of derivatives. Systematic comparison of convergence behavior across methods and tolerance settings.
- Methods implemented: Bisection, Golden Section, Fibonacci search
- Contains MATLAB scripts (`.m`) and the technical report (`.pdf`)

### `02-Unconstrained-Minimization/` — Unconstrained Minimization of Multivariable Functions
Gradient-based minimization of multivariable objective functions using first- and second-order derivative information. Multiple functions and starting points are tested to compare convergence rate, stability, and computational cost across methods.
- Methods implemented: Steepest Descent, Newton's Method, Levenberg-Marquardt
- Contains MATLAB scripts and the technical report

### `03-Projected-Gradient-Method/` — Constrained Optimization via the Projected Gradient Method
Constrained minimization using the Projected Steepest Descent method. Gradient steps are projected onto the feasible set defined by inequality constraints, with analysis of convergence under varying step sizes and constraint geometries.
- Methods implemented: Projected Steepest Descent
- Contains MATLAB scripts and the technical report

### `04-Genetic-Algorithms-Traffic-Flow/` — Network Traffic Flow Minimization via Genetic Algorithms
Application of Genetic Algorithms to minimize total vehicle travel time in a simulated road network operating under specific link capacity constraints. The formulation treats the problem as a combinatorial optimization task, solved using population-based evolutionary search.
- Methods implemented: Genetic Algorithms (`ga`)
- Contains MATLAB scripts and the technical report

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
