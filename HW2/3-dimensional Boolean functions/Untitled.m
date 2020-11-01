% a=randi(2,1)-1;
% b=randi(2,1)-1;
% c=randi(2,1)-1;
% d=randi(2,1)-1;
% w=randi(2,1)-1;
% x=randi(2,1)-1;
% y=randi(2,1)-1;
% z=randi(2,1)-1;
% a=0;b=1;c=0;d=1;w=0;x=1;y=0;z=0;
a=0;b=0;c=1;d=0;w=0;x=1;y=0;z=0;
bad=false;
if(a==d && b==c && a~=b)
    bad=true;
end
if(a==y && w==c && a~=w)
bad=true;
end
if(w==z && x==y && w~=x)
bad=true;
end
if(x==d && b==z && x~=b)
bad=true;
end
if(a==x && b==w && a~=w)
bad=true;
end
if(y==d && z==c && d~=z)
bad=true;
end
if(a==z && c==x && a~=x)
bad=true;
end
if(b==y && d==w && b~=w)
bad=true;
end
if(a==z && b==y && a~=y)
bad=true;
end
if(c==x && d==w && c~=w)
bad=true;
end
if(a==z && w==d && a~=w)
bad=true;
end
if(c==x && b==y && c~=y)
bad=true;
end
bad