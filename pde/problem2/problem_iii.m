function problem_iii()
    u = helper.xy_function(@u_polar);
    d = 0.1 .^ (0:50);
    quotient_seq = back_diff_quotient(u, 0, 0, 'x', d);

    plot(quotient_seq);
    lgd = legend('Backward difference quotient');
    lgd.Location = 'southwest';
    % Judging by the plotting result, the quotient sequence is divergent,
    % so u is not differentiable on (0, 0).

end

function result = back_diff_quotient(func, x, y, var, d)
% Calculate backwards difference quotient.
    if var == 'x'
        result = (func(x, y) - func(x - d, y)) ./ d;
    elseif var == 'y'
        result = (func(x, y) - func(x, y - d)) ./ d;
    else
        error('var can only be ''x'' or ''y''.');
    end
end

function z = u_polar(r, phi)
% Function u in polar coordinates
    z = r.^(2/3) .* sin( (2*phi - pi)/3 );
end