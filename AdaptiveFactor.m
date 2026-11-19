function [FL,AP,F,beta] = AdaptiveFactor(iter,MaxIter)

t = iter/MaxIter;

%----------------------------------
% Adaptive Flight Length
%----------------------------------

FL = 2*cos(pi*t/2)+0.5;

%----------------------------------
% Awareness Probability
%----------------------------------

AP = 0.05+0.25*t^2;

%----------------------------------
% Mutation Factor
%----------------------------------

F = 0.25+0.65*(1-t)^2;

%----------------------------------
% Elite Attraction
%----------------------------------

beta = sin(pi*t);

end