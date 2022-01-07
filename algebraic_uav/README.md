# Algebraic UAV example
This folder is concerned with turning the UAV example from the papers into a Julia script. The dynamics equations were taken from this tutorial on system behavior:
- [Aircraft pitch: System modelling](https://ctms.engin.umich.edu/CTMS/index.php?example=AircraftPitch&section=SystemModeling)

To check the results from the wiring diagrams, a matlab script was used to solve the equations in the tutorial for a set of initial conditions. This provides a reference  to check the output of the Julia notebook. If it works correctly, the notebook should output the same result as the matlab script:  

![Alt text](https://github.com/rgCategory/composition_notebook/blob/main/images/aircraft_pitch.jpg?raw=true)

There are two versions of the notebook, a complete version and a basic version. The complete version includes examples of how the coefficients change the system's behavior. The basic version skips these examples and focuses on showing equations being assigned to the wiring diagram.
