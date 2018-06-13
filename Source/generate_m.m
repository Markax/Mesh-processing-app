function m_file = generate_m(fname)

[filepath,name,ext] = fileparts(fname);

%maxx;maxy;maxz;minx;miny;minz;
%fichero_m; fichero_land;

%fin1 = fichero.substr(fichero.length()-4,4);
%fin2 = fichero.substr(fichero.length()-5,5);
%transform(fin1.begin(), fin1.end(), fin1.begin(), ::toupper);
%transform(fin2.begin(), fin2.end(), fin2.begin(), ::toupper);

if (isequal(ext, '.obj'))
    % Generacion de ficheros m y land 
    
    fichero_m = fname( 1 : length(fname)-4) + ".m";
    
    fichero_land = fname(1 : length(fname)-4) + ".landmarkAscii";
    disp(fichero_m);
else
    if (isequal(ext, '.ETIQ'))
        fichero_m = fname( 1 : length(fname)-4) + ".m";
    
        fichero_land = fname(1 : length(fname)-4) + ".landmarkAscii";
        disp(fichero_m);
        
            disp('En construccion');
    else
        disp('genera_M: Error: solo se admiten fichero .OBJ o .ETIQ');
        return;
    end    
end

if (isequal(ext, '.obj'))
    fid = fopen(fichero_m,'w');
    
    % Header 
    fprintf(fid, "%% Superficie generada a partir de un fichero .obj ");
    fprintf(fid, "%% superficie %s (%d vertices, %d triangulos)\n");
    
    % lanzamiento al archivo de los v�rtices 
    fprintf(fid,"surface = struct('vertices', [");

    for i = 0:s.length
        fprintf(fid, "%f %f %f;...\n", s.vertices(i).x, s.vertices(i).y, s.vertices(i).z);
    end
    fprintf(fid, "]);\n");
    fprintf(fid, "p = patch(surface);");
    
    % fin archivo
    fclose(fid);

end

if (isequal(ext, '.ETIQ'))
    
    fid = fopen(fichero_m,'w');
    
    % Header 
    fprintf(fid, "%% Superficie generada a partir de un fichero .asc de FreeSurfer\n");
    fprintf(fid, "%% superficie %s (%d vertices, %d triangulos)\n");
    
    % lanzamiento al archivo de los v�rtices 
    fprintf(fm,"surface = struct('vertices', [");

    for i = 0:s.length
			fprintf(fm, "%f %f %f;...\n", s.vertices(i).x, s.vertices(i).y, s.vertices(i).z);
    end

    fprintf(fm, "]);\n");
    fprintf(fm, "p = patch(surface);");
    
    % fin archivo
    fclose(fm);
    
end

% fichero con landmarks
fland=fopen(fichero_land.c_str(),"w");

minx = s.vertices(0).x; maxx = s.vertices(0).x;
miny = s.vertices(0).y; maxy = s.vertices(0).y;
minz = s.vertices(0).z; maxz = s.vertices(0).z;

for i = 1:s.vertices.size()
		if (s.vertices(i).x < minx) minx = s.vertices(i).x; end
		if (s.vertices(i).x > maxx) maxx = s.vertices(i).x; end
		if (s.vertices(i).y < miny) miny = s.vertices(i).y; end
		if (s.vertices(i).y > maxy) maxy = s.vertices(i).y; end
		if (s.vertices(i).z < minz) minz = s.vertices(i).z; end
		if (s.vertices(i).z > maxz) maxz = s.vertices(i).z; end
end

fprintf(fland, "# UJA-SHFD\n\n\n");
fprintf(fland, "define Markers 8\n");
fprintf(fland, "Parameters {\n");
fprintf(fland, "    NumSets 1,\n");
fprintf(fland, '    ContentType \"LandmarkSet\"\n');
fprintf(fland, "}\n\n");
fprintf(fland, "Markers { float[3] Coordinates } @1\n\n");
fprintf(fland, "# Data section follows\n");
fprintf(fland, "@1\n");

fprintf(fland,"%f %f %f\n", minx, miny, minz);
fprintf(fland,"%f %f %f\n", minx, miny, maxz);
fprintf(fland,"%f %f %f\n", maxx, miny, maxz);
fprintf(fland,"%f %f %f\n", maxx, miny, minz);

fprintf(fland,"%f %f %f\n", minx, maxy, minz);
fprintf(fland,"%f %f %f\n", minx, maxy, maxz);
fprintf(fland,"%f %f %f\n", maxx, maxy, maxz);
fprintf(fland,"%f %f %f\n", maxx, maxy, minz);

fclose(fland);