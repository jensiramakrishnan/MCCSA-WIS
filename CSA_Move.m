function Xnew = CSA_Move(Xi,Memj,FL,AP,lb,ub)

dim = length(Xi);

if rand > AP

    r = rand(1,dim);
    Xnew = Xi + r.*FL.*(Memj-Xi);

else

    Xnew = lb + rand(1,dim).*(ub-lb);

end

end