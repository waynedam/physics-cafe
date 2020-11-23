function plotvector(v, fignum, colour, linewidth)

quiver3(0,0,0,v(1), v(2),v(3), colour, 'LineWidth', linewidth)

figure(fignum)

end
