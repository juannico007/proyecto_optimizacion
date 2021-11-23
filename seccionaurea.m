function v = seccionaurea(a, b, la, u, p, i, f)
%     disp([i, a, b, la, u, f(la), f(u)])
%     disp('-----------------------------------------------')
    if b - a <= 0.01
        v = la;
    else
        if f(la) >= f(u)
            a = la;
            la = u;
            u = a + p*(b -a);
            v = seccionaurea(a, b, la, u, p, i + 1,f);
        else
            b = u;
            u = la;
            la = a + (1 - p)*(b - a);
            v = seccionaurea(a, b, la, u, p, i + 1,f);
        end
    end
    return 
end
