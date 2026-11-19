function Child = WavePacketInterferenceSearch(Target, Mutant, lb, ub, iter, MaxIter)
    % Quantized Wave-Packet Interference Crossover (Vectorized & Coupled)
    
    % 1. Enforce row vector limits dynamically matching the inputs
    dim = size(Target, 2);
    lb = lb .* ones(1, dim);
    ub = ub .* ones(1, dim);
    
    % 2. Calculate global spatial Euclidean distance (Cross-dimensional coupling)
    % This breaks the isolated-dimension limitation of the original version
    TotalDistance = norm(Mutant - Target);
    NormFactor = norm(ub - lb) + eps;
    SpatialCoupling = TotalDistance / NormFactor;

    % 3. Dynamic Wave Number (k) - Controls wave packet compression over time
    % Transitions from broad exploratory packets to sharp local exploitation
    k = 0.5+(1 - iter / MaxIter)^0.5; 

    % 4. Element-wise normalized distance matrix
    DistanceX = abs(Mutant - Target) ./ (ub - lb + eps);
    
    % 5. Novel Quantum Wave-Packet Generator
    % Combines an envelope function (Gaussian dispersion) with a high-freq carrier wave
    Phase = k * pi * DistanceX * (1 + SpatialCoupling);
    Envelope = exp(-0.5 * (Phase / pi).^2); % Dampens extreme out-of-bounds variations later in the run
    
    % Interference Matrix (Ranges dynamically based on the wave envelope)
    W = Envelope .* cos(-2 * pi * Phase); 

    % 6. Quantum Superposition Step 
    % Generates child through damped wave superposition
    Child = 0.5 * (Mutant + Target) + 0.5 * W .* (Mutant - Target);
    
    % 7. Fast Vectorized Boundary Clip
    Child = max(min(Child, ub), lb);
end
