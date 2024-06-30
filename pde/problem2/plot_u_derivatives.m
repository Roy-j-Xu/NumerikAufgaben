function plot_u_derivatives()
    u_r = helper.xy_function(@u_r_polar);
    u_phi = helper.xy_function(@u_phi_polar);

    subplot(1, 2, 1);
    helper.plot_in_L_shape(u_r, 0.02);
    title("u_r");

    subplot(1, 2, 2);
    helper.plot_in_L_shape(u_phi, 0.02);
    title("u_\phi");

end

function z = u_r_polar(r, phi)
% Partial derivative of u with respect to r
    z = 2/3 * r.^(-1/3) .* sin( (2*phi - pi)/3 );
end

function z = u_phi_polar(r, phi)
% Partial derivative of u with respect to phi
    z = 2/3 * r.^(2/3) .* cos( (2*phi - pi)/3 );
end