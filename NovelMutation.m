function V = NovelMutation(Xi,Best,Xr1,Xr2,F,beta)

% Proposed mutation

V = Best+ F.*(Xr1-Xr2)+ beta.*rand(size(Xi)).*(Best-Xi);

end