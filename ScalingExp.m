%ObjVΪĿ�꺯��ֵ ����Ϊ������Ҳ����Ϊ���� ԽС��Ӧ��Խ�� 
function [f,fmin,fmax,fave] = ScalingExp(ObjV,alpha)
f = exp(-alpha.*ObjV);
fmin = min( f ) ;
fmax = max( f ) ;
fave = mean( f );
end
