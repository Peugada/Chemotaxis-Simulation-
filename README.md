# Chemotaxis Simulation

## Project Overview

This project uses MATLAB to simulate bacterial run-and-tumble movement based on a mathematical model of chemical concentration and position-dependent tumbling probability.

The project was inspired by a biophysics laboratory assignment and explores how computational modeling and AI-assisted learning can support scientific understanding.

## Mathematical Model

Chemical concentration:

\[
z(x,y)=\frac{1}{1+0.001(x^2+y^2)}
\]

Tumbling probability:

\[
P_{\text{tumble}}(x,y)=1-z(x,y)
\]

## Simulation Outputs

The MATLAB script generates five visualizations:

1. Chemical concentration field
2. Bacterial trajectories
3. Horizontal position versus time
4. Vertical position versus time
5. Average tumbling probability versus time

## How to Run

1. Download `Chemotaxis_Simulation_Simple.m`.
2. Open the file in MATLAB.
3. Click Run.
4. The simulation generates five figures and saves them in a Results folder.

## Tools

- MATLAB
- Computational Modeling
- Biophysics
- Artificial Intelligence

## Important Note

The simulation uses random bacterial movement with a position-dependent tumbling probability. It does not include an additional directional bias toward the chemical source.
