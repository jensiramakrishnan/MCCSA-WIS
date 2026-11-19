function [Best_pos,Best_score,exectime,val,addcavg]=MCCSAV1( ...
    SearchAgents_no,...
    Max_iter,...
    lb,...
    ub,...
    dim,...
    fhd,funnum)

%% Initialization
 time1 = tic;
X = Initialization(SearchAgents_no,dim,ub,lb);

Memory = X;

Fitness = zeros(SearchAgents_no,1);
MemoryFitness = zeros(SearchAgents_no,1);

for i=1:SearchAgents_no

    Fitness(i)=feval(fhd,X(i,:)',funnum);
    MemoryFitness(i)=Fitness(i);

end
FES=SearchAgents_no;
[Best_score,index]=min(MemoryFitness);
Best_pos=Memory(index,:);
  val(1, :) = [FES, Best_score];
% Convergence_curve=zeros(1,Max_iter);

%% Main Loop

for iter=2:Max_iter

    % Adaptive parameters
    [FL,AP,F,beta]=AdaptiveFactor(iter,Max_iter);

    for i=1:SearchAgents_no

        %% ------------------------------
        % Standard Crow Movement
        %% ------------------------------

        j=randi(SearchAgents_no);

        while j==i
            j=randi(SearchAgents_no);
        end

        Xmove=CSA_Move( ...
            X(i,:),...
            Memory(j,:),...
            FL,...
            AP,...
            lb,...
            ub);

        %% ------------------------------
        % Elite-guided Mutation
        %% ------------------------------

        r=randperm(SearchAgents_no);

        r(r==i)=[];

        r1=r(1);
        r2=r(2);
        

        Mutant=NovelMutation( ...
            Xmove,...
            Best_pos,...
            X(r1,:),...
            X(r2,:),...
            F,...
            beta);


        %% ------------------------------
        % Novel Distance-Adaptive Crossover
        %% ------------------------------

%         Trial=NovelCrossover( ...
%             Xmove,...
%             Mutant,...
%             lb,...
%             ub);
%             Trial = WaveInterferenceCrossover(...
%     Xmove,...
%     Mutant,...
%     lb,...
%     ub,...
%     iter,...
%     Max_iter);
  Trial = WavePacketInterferenceSearch(...
    Xmove,...
    Mutant,...
    lb,...
    ub,...
    iter,...
    Max_iter);

        %% ------------------------------
        % Boundary Control
        %% ------------------------------

        Trial=BoundaryCheck(Trial,lb,ub);

        %% ------------------------------
        % Fitness Evaluation
        %% ------------------------------

        TrialFitness=feval(fhd,Trial',funnum);
        FES=FES+1;
        %% ------------------------------
        % Greedy Selection
        %% ------------------------------

        if TrialFitness<Fitness(i)

            X(i,:)=Trial;
            Fitness(i)=TrialFitness;

        end

        %% ------------------------------
        % Memory Update
        %% ------------------------------

        if Fitness(i)<MemoryFitness(i)

            Memory(i,:)=X(i,:);
            MemoryFitness(i)=Fitness(i);

        end

    end

    %% Update Global Best

    [CurrentBest,index]=min(MemoryFitness);

    if CurrentBest<Best_score

        Best_score=CurrentBest;
        Best_pos=Memory(index,:);

    end

%     Convergence_curve(iter)=Best_score;

    if mod(iter,20)==0

        fprintf('Iteration %4d   Best Fitness = %f\n',...
            iter,Best_score);

    end
% Record Best Score
        addcavg(iter) = Best_score;
        val(iter, :) = [FES, Best_score];

end
 % Execution Time
    exectime = toc(time1);
end