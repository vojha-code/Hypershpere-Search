# Equilibrium - Space Truss Structure Optimization 
Civil Engineering Problem: Space Truss Structure Equilibrium Optimization and Analysis.

## An Example

### Problem - Sixteen Members
A load is applied vertically downward on the structure shown below. This produced a buckling effect on the structure, and it displaces downward. This displacement follows an equilibrium path. The goal is to find this equilibrium path. This is a multimodal optimization problem.

![](https://github.com/vojha-code/equilibrium/blob/main/imgs/sixteen_member.png)

### Solution - Sixteen Members

![](https://github.com/vojha-code/equilibrium/blob/main/imgs/sixteen_member_sol.png)

## MATLAB Code Structure

- Algorithms
- Curves
- Data
- ObjectiveFunc
- ProblemSetting
- Structure_Problems

Main
Domain Analysis Trials
```
main_optimize_structure_main_trails.m
```
Discrete Domain Analysis Trials
```
main_optimize_structure_discrete.m
```
Incremental Hypershpere Search Methods Trials
```
main_optimize_structure_hypersphere.m
```

