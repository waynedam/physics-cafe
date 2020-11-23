function plotvector(v, fignum, colour, linewidth)
% v - (3 element vector) vector to be plotted. Must be a 3 element vector or 3x1 or 1x3 array.
% fignum - (integer 1,2,3, ...) the figure number (1,2, etc.) to be plotted in.
% colour - (single character in quotes) colour of the plotted vector in the Matlab colouring scheme:
%		 - 'k':black, 'r':red, 'b':blue, 'g':green, etc.
% linewidth (integer 1,2,3, ...) the linewidth of the plotted vector
% 
% Examples: 
% figure(1), clf 					% Selects figure 1 and clears it.
% plotvector( [1,2,3], 1, 'b', 3) 	% A plot
% v = rand(3,1) 					% A random vector
% plotvector( v, 1, 'k', 1) 		% Plot it


% Select figure.
figure(fignum) 

% Plot the arrow.
quiver3(0,0,0,v(1), v(2),v(3), colour, 'LineWidth', linewidth)

end
