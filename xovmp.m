% XOVMP.m                Multi-point crossover
%
%       Syntax: NewChrom =  xovmp(OldChrom, Px, Npt, Rs)
%
%       This function takes a matrix OldChrom containing the binary
%       representation of the individuals in the current population,
%       applies crossover to consecutive pairs of individuals with
%       probability Px and returns the resulting population.
%
%       Npt indicates how many crossover points to use (1 or 2, zero
%       indicates shuffle crossover).
%       Rs indicates whether or not to force the production of
%       offspring different from their parents.
%
%
% Author: Carlos Fonseca, 	Updated: Andrew Chipperfield
% Date: 28/09/93,		Date: 27-Jan-94
%
% tested under MATLAB v6 by Alex Shenfield (22-Jan-03)

function NewChrom = xovmp(OldChrom, couple, Npt, Rs)
%         Nptָ����������� 0 ϴ�ƽ��棻1 ���㽻�棻2 ���㽻�棻  Ĭ��Ϊ0
%        Rsָ��ʹ�ü��ٴ��� 0 �����ٴ���1 ���ٴ���  Ĭ��Ϊ0
Px = 1;
% Identify the population size (Nind) and the chromosome length (Lind)
Nind = couple(1);
Lind = couple(2);

if Lind < 2
NewChrom = OldChrom; 
return; 
end

Xops = floor(Nind/2);
DoCross = rand(Xops,1) < Px;
odd = 1:2:Nind-1;
even = 2:2:Nind;

% Compute the effective length of each chromosome pair
Mask = ~Rs | (OldChrom(odd, :) ~= OldChrom(even, :));
Mask = cumsum(Mask')';

% Compute cross sites for each pair of individuals, according to their
% effective length and Px (two equal cross sites mean no crossover)
xsites(:, 1) = Mask(:, Lind);
if Npt >= 2
        xsites(:, 1) = ceil(xsites(:, 1) .* rand(Xops, 1));
end
xsites(:,2) = rem(xsites + ceil((Mask(:, Lind)-1) .* rand(Xops, 1)) ...
                                .* DoCross - 1 , Mask(:, Lind) )+1;

% Express cross sites in terms of a 0-1 mask
Mask = (xsites(:,ones(1,Lind)) < Mask) == ...
                        (xsites(:,2*ones(1,Lind)) < Mask);

if ~Npt
        shuff = rand(Lind,Xops);
        [~,shuff] = sort(shuff);
        for i=1:Xops
          OldChrom(odd(i),:)=OldChrom(odd(i),shuff(:,i));
          OldChrom(even(i),:)=OldChrom(even(i),shuff(:,i));
        end
end

% Perform crossover
NewChrom(odd,:) = (OldChrom(odd,:).* Mask) + (OldChrom(even,:).*(~Mask));
NewChrom(even,:) = (OldChrom(odd,:).*(~Mask)) + (OldChrom(even,:).*Mask);

% If the number of individuals is odd, the last individual cannot be mated
% but must be included in the new population
if rem(Nind,2)
  NewChrom(Nind,:)=OldChrom(Nind,:);
end

if ~Npt
        [~,unshuff] = sort(shuff);
        for i=1:Xops
          NewChrom(odd(i),:)=NewChrom(odd(i),unshuff(:,i));
          NewChrom(even(i),:)=NewChrom(even(i),unshuff(:,i));
        end
end

% end of function