function Husband = FusionOperator(Husband,Wife,Couple,fitnessFunc)
%�ں����� https://wenku.baidu.com/view/df61e0d165ce05087632137b.html
%����������

F1 = fitnessFunc(Husband);
F2 = fitnessFunc(Wife);
Base = F2./(F1 + F2)*ones(1,Couple(2));
idx = (Husband ~= Wife);
Pro = rand(Couple);
flag = Pro < Base;
Husband(idx) = (1 - flag(idx)).*Wife(idx);

end