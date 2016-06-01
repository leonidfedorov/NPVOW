function exampleCylinder(ambStr, speStr, difStr, specExp, lightAngle, fixedColor)
%this function sets the appearance of the cylinder: ambientStrength, 
%specularStrength, diffusionStrength, specularExponent. 
%%
%Besides surface properties, the lighting changes the resulting rendered 
%image in MATLAB. This is best done by a light angle change and
%the view of the figure.
%%
%Also if we ignore the lighting/surface and set the cylinder to a single
%color by giving an RGB value to fixedColor. If its set to [Inf Inf Inf],
%then the regular surface shading applies.


%figure 'Position' is in screen pixel coordinates: 
%[positionX, positionY, sizeX, sizeY], then RGB 'Color'.
mainfigure = figure; set(mainfigure, 'Position', [50 60 900 900], 'Color', [0.5 0.5 0.5]);

cla; clf;

mainaxes = axes('Parent', mainfigure); axis manual;
axis(mainaxes,[-200 600 -200 600 -1200 1800]); axis equal;
hold(mainaxes, 'all');


%set the shading, light and renderer
shading(mainaxes,'interp');
mainlight = light('Parent', mainaxes, 'Position', [2500*sin(lightAngle) 0 -2500*cos(lightAngle)]); 
set(get(mainaxes,'Parent'),'Renderer','zbuffer','DoubleBuffer','on');

%generate the cylinder mesh
[x,y,z] = CYL([500, 500, 500], [900 900 900], [900 900 900], 200, 0, 10);

%plot the surface from the mesh, at the given axes with the specified
%appearance
example_surf = surf(x, y , z, 'Parent', mainaxes, 'LineStyle', 'none', 'AmbientStrength', ambStr, 'SpecularStrength', speStr, 'DiffuseStrength', difStr, 'SpecularExponent', specExp);

%set the surface properties, either to constant color, or to shaded color
if sum(fixedColor) ~= Inf
    set(example_surf, 'FaceLighting', 'none', 'FaceColor',[fixedColor(1) fixedColor(2) fixedColor(3)]);
else
    set(example_surf, 'FaceLighting', 'gouraud', 'FaceColor', [0.99 0.99 0.99]);
end

end
