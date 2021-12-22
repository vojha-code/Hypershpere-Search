# Equilibrium - Space Truss Structure Optimization 
Introduction to a Civil Engineering Problem: Space Truss Structure Equilibrium Optimization and Analysis. This is a multistep incremental procedure based on gradient-free optimization algorithms for nonlinear pre- and post-buckling analyses of space truss structures subjected to large displacements. This is a class of nonlinear, multimodal, unconstrained, continuous minimization problems. This code solves three problems:  
1. Benchmark 1: Eight-Member Shallow Truss Structure
2. Benchmark 2: Sixteen-Member Shallow Truss Structure 
3. Test Problem: 3D reticular beam 

## Example 

### Problem - Sixteen-Member Shallow Truss Structure
A load is applied vertically downward on the structure shown below. This produced a buckling effect on the structure, and it displaces downward. This displacement follows an equilibrium path. The goal is to find this equilibrium path. This is a multimodal optimization problem.

<img src="https://github.com/VarunKumarOjha/equilibrium/blob/main/imgs/sixteen_member.png" alt="drawing" width="500"/>
<!--- ![](https://github.com/VarunKumarOjha/equilibrium/blob/main/imgs/sixteen_member.png) -->

**Figure.** Sixteen-Member Shallow Truss Structure. _Left:_ Top View. _Right:_ Side View. The central node is indicated by a lighter color dot in the Top view and a light color arrow pointer in the side view. The arrow on the side view indicates a vertical downward external force of 4450kN applied on the central node.

### Solution - Sixteen Members

<img src="https://github.com/VarunKumarOjha/equilibrium/blob/main/imgs/sixteen_member_sol.png" alt="drawing" width="500"/>

**Figure.** Solutions on equilibrium path characterized by verticle and non-vertical force on the structure.  The black line is the analytical solution and the points are solutions obtained by applying optimization algorithms.

### Optimization Algorithms

<img src="https://github.com/VarunKumarOjha/equilibrium/blob/main/imgs/algorithms.png" alt="drawing" width="500"/>

**Figure.** Convergence analysis of algorithms over (all) solutions with equilibrium value 10^{-5} on Eight-member shallow truss structure problem. Algorithms are Artificial Bee Colony (ABC), Ant Colony Optimization (ACO), Differential Evolution (DE/best/2/bin), Differential Evolution (DE/rand/1/bin), Direct, Particle Swarm Optimization Constriction (PSO-Const), Particle Swarm Optimization Standard  (PSO-Std), and Simulated Annealing (SA).

## MATLAB Code Structure

- Algorithms
- Curves
- Data
- ObjectiveFunc
- ProblemSetting
- Structure_Problems

_Dependencies:_ Code has no dependencies, but it acknowledges and refers yarpiz for optimization algorithms implementation. All other (problem and framework) implementations require no dependecies. 

MATLAB Version used for the implemnetation is MATLAB R2020a


### Domain Analysis Trials

Main
```Matlab
main_optimize_structure_main_trails.m
```
Decomposed Domain Analysis Trials
```Matlab
main_optimize_structure_discrete.m
```

### Hypershpere Search Methods Trials
```Matlab
main_optimize_structure_hypersphere.m
```
### Note on Running this code.
These three commands/files are for running three different sets of analysis. The first main file is to perform basic trials on the full domain of the problem. The second file helps partition the space. The third file helps perform the hypersphere search algorithm. The setting of the problems is in the ProblemSetting folder. These need to be manually tuned as per the requirement as their arguments for the analysis are not passed through the command line but the MATLAB scripts require to be updated for varied settings. There are several objective function evaluation files options. These options are there to help run algorithms converge faster. For instance, converting a 100 mm displacement into 10cm or 1000mm into 1m helps algorithms converge better. 


