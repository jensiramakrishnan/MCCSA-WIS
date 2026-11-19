# MCCSA-WIS
MATLAB implementation of MCCSA-WIS: Mutation-Controlled Crow Search Algorithm with Wave-Packet Interference Search for Global Optimization

## Files Included
- `main.m` — Demo script to run MCCSA-WIS on benchmark functions.
- `MCCSAV1.m` — Main optimization loop.
- `Initialization.m` — Uniform population initialization.
- `CSA_Move.m` — Awareness-guided crow movement operator.
- `AdaptiveFactor.m` — Nonlinear adaptive parameter schedules (`FL`, `AP`, `F`, `beta`).
- `NovelMutation.m` — Elite-guided differential mutation operator.
- `WavePacketSearch.m` — Cross-dimensionally coupled Wave-Packet Interference Search (`WIS`).
- `BoundaryCheck.m` — Search space boundary constraint handler.

## Usage
Open MATLAB, navigate to the repository folder, and run:
```matlab
main
```
