function plot_u()
    u = helper.xy_function(@u_polar);
    helper.plot_in_L_shape(u, 0.02);
end

function z = u_polar(r, phi)
% Function u in polar coordinates
    z = r.^(2/3) .* sin( (2*phi - pi)/3 );
end