%ObjVΪĿ�꺯��ֵ Ҫ��Ϊ���� ԽС��Ӧ��Խ�� 
function f = ScalingNew(ObjV,g,MaxGen)

m = 1 + log(MaxGen);
f = floor(g^(1/m))./ObjV;
% fmin = min( f ) ;
% fmax = max( f ) ;
% fave = mean( f );
