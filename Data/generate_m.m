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
    disp('ole');
    
    fid = fopen(fichero_m,'w');
    
    % Header 
    fprintf(fid, "%% Superficie generada a partir de un fichero .obj ");
    fprintf(fid, "%% superficie %s (%d vertices, %d triangulos)\n");
    
    % lanzamiento al archivo de los v�rtices 
    fprintf(fm,"surface = struct('vertices', [");
    ------------------
    for i = 0:s.length
        fprintf(fm, "%f %f %f;...\n", s.vertices[i].x, s.vertices[i].y, s.vertices[i].z);
    end
    --------------------
end

if (isequal(ext, '.ETIQ'))
    
    fid = fopen(fichero_m,'w');
    
    % Header 
    fprintf(fid, "%% Superficie generada a partir de un fichero .asc de FreeSurfer\n"); ");
    fprintf(fid, "%% superficie %s (%d vertices, %d triangulos)\n");
    
    % lanzamiento al archivo de los v�rtices 
    fprintf(fm,"surface = struct('vertices', [");
    ----------------------
    for i = 0:s.length
			fprintf(fm, "%f %f %f;...\n", s.vertices[i].x, s.vertices[i].y, s.vertices[i].z);
    end
    ----------------------
    
end
