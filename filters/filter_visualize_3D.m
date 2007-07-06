% Used to visualize a 3D filter.
%
% Dark lobes correspond to negative areas.  Surfaces shown are drawn at a
% percentage of the peak filter response detemined by frac.
%
% USAGE
%  filter_visualize_3D( F, frac, [show] )
%
% INPUTS
%  F       - 3D filter to visualize
%  frac    - frac of max value of F at which to draw surfaces.
%  show    - [1] figure to use for display (0->uses current)
%
% OUTPUTS
%
% EXAMPLE
%  F = filterDoog( [51 51 101], [3 3 5], [1 2 3], 0 );
%  filter_visualize_3D( F, .1, 1 );
%
% See also FILTER_VISUALIZE_2D

% Piotr's Image&Video Toolbox      Version NEW
% Written and maintained by Piotr Dollar    pdollar-at-cs.ucsd.edu
% Please email me if you find bugs, or have suggestions or questions!

function filter_visualize_3D( F, frac, show )

if( nargin<2 || isempty(frac)); frac = .1; end % 10% of peak
if( nargin<3 || isempty(show) ); show=1; end
if( show>0); figure( show ); clf; end

% better visualization this way, t left to right
F = flipdim( permute( F, [3, 1, 2] ), 1 );

% approximate display as surface (may miss lots of lobes!!!)
maxval = max(abs(F(:)));
washeld = ishold;  if(~washeld); hold('on'); end
p = patch(isosurface( F>frac*maxval, 0 ));
set(p,'FaceColor',[.9 .9 .9],'EdgeColor','none'); % light gray lobes
p2 = patch(isosurface( F<-frac*maxval, 0 ));
set(p2,'FaceColor',[.4 .4 .4],'EdgeColor','none'); % dark gray lobes

% set view
daspect([1 1 1]); view(3); axis tight;
camlight; lighting gouraud; set(gca,'Box','on');
set(gca,'YTick',[]); set(gca,'XTick',[]); set(gca,'ZTick',[]);
xlabel('y'); ylabel('t'); zlabel('x');
if(~washeld); hold('off'); end
