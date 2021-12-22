# Equilibrium - Space Truss Structure Optimization 
Civil Engineering Problem: Space Truss Structure Equilibrium Optimization and Analysis.

## An Example

### Problem - Sixteen-Member Shallow Truss Structure
A load is applied vertically downward on the structure shown below. This produced a buckling effect on the structure, and it displaces downward. This displacement follows an equilibrium path. The goal is to find this equilibrium path. This is a multimodal optimization problem.

<img src="https://github.com/VarunKumarOjha/equilibrium/blob/main/imgs/sixteen_member.png" alt="drawing" width="500"/>
<!--- ![](https://github.com/VarunKumarOjha/equilibrium/blob/main/imgs/sixteen_member.png) -->

**Figure.** Sixteen-Member Shallow Truss Structure. _Left:_ Top View. _Right:_ Side View. The central node is indicated by a lighter color dot in the Top view and a light color arrow pointer in the side view. The arrow on the side view indicates a vertical downward external force of 4450kN applied on the central node.

### Solution - Sixteen Members

<img src="https://github.com/VarunKumarOjha/equilibrium/blob/main/imgs/sixteen_member_sol.png" alt="drawing" width="500"/>

**Figure.** Solutions on equilibrium path characterized by verticle and non-vertical force on the structure.  The black line is the analytical solution and the points are solutions obtained by applying optimization algorithms.

## MATLAB Code Structure

- Algorithms
- Curves
- Data
- ObjectiveFunc
- ProblemSetting
- Structure_Problems

### Main Domain Analysis Trials
```console
$ main_optimize_structure_main_trails.m
```
Discrete Domain Analysis Trials
```console
$ main_optimize_structure_discrete.m
```

### Hypershpere Search Methods Trials
```console
$ main_optimize_structure_hypersphere.m
```

