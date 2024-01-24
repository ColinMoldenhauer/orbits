function E = solve_E(M, e, eps, max_it)
    E = M;
    for i=1:max_it
        dE = (M-E+e*sin(E))./(1-e*cos(E));
        if (max(abs(dE)) < eps)
            break
        end
        E = E + dE;
    end
    fprintf('Keplers Equation solved after %d iterations \n\t(max_it: %d, eps: %.1e)\n', i, max_it, eps)
end