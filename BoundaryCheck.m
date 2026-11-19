function X = BoundaryCheck(X,lb,ub)

X = max(X,lb);
X = min(X,ub);

end