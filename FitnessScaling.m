%linear:nonegative value fintnees Խ���Խ��
%rank:�����Կ� ֵԽСԽ��
%exp:����Ϊ������Ҳ����Ϊ���� ԽС��Ӧ��Խ�� 
%MGA:ԽСԽ�� ��������Լ������
function f = FitnessScaling(SMethod,F,varargin)

if strcmpi(SMethod,'linear')  
    Smul = varargin{1};
    f = ScalingLinear(F,Smul);
elseif strcmpi(SMethod,'rank')
    SP = varargin{1};
    F = - F;
    f = ScalingRank(F,SP);
elseif strcmpi(SMethod,'exp')
    alpha = varargin{1};
    F = - F;
    f = ScalingExp(F,alpha);
elseif strcmpi(SMethod,'MGA')
    g = varargin{2};
    MaxGen = varargin{3};
    f = ScalingNew(F,g,MaxGen);
end

