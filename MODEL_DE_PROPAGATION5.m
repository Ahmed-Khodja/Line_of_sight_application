clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LINE OF SIGHT APPLICATION %%%%%%%%%%%%%%%%%%%
pythonCmd = 'C:\Users\Git\AppData\Local\Programs\Python\Python311\python.exe';  %%%%%%%%%%%%%%%%%%%%%%%%%COMMANDE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pythonFile = 'C:\CY_ENNA_Tool\gui.py';  %%%%%%%%%%%%%%%%%%%%fichier python executable%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

system([pythonCmd ' ' pythonFile]);


%%%%%%%%%%%%%%%%%%%%coordonées de VHF choisi %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
VhfCoor = 'C:\CY_ENNA_Tool\DATA\VHF_DATA.csv';



%%%%%%%%%%%%%%%%%%%%%%%%% fichier CSV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data1 = readtable(VhfCoor);
lat1 = data1{1, 1};  %
lon1 = data1{1, 2};  %
h1=data1{1, 3};



%%%%%%%%%%%%%%%%%%%% coordonnées de l'aéronef %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AircraftCoor = 'C:\CY_ENNA_Tool\DATA\Aircraft_DATA.csv';

%%%%%%%%%%%%%%%%%%%%%%%%% fichier CSV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data2 = readtable(AircraftCoor);
lat2 = data2{1, 1}; 
lon2 = data2{1, 2};  
h2=data2{1, 3};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% données de l'application LOS %%%%%%%%%%%%%%%%%%%%%%%%
LosData = 'C:\CY_ENNA_Tool\OUTPUT\DataForMatlab.csv';

%%%%%%%%%%%%%%%%%%%%%%%%%%% fichier CSV  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data3 =  csvread(LosData);
LOS = data3(1, 1);  % Access the first column
ELV1 = data3(2, 1);  % Access the second column
ELV2 = data3(3, 1);

%%%%%%%%%%%%%%%%%% fréquence de travail %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=125; %%%%%%% valeur moyenne de la fréquence de 125 Mhz 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if LOS==0
    fprintf('présence de relief \nmanque de visibilité directe\n')         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%le cas ou y'a pas line of sight%%%%%%%%%%%%%%%%%%%%%%%
else
    
    

%%%%%%%%%%%%%%%%%%%%%%% CONVERSION DES COORDONNEES DE DEGREE EN RADIAN%%%%%%%%%%%%%%%%%%%%%%%

    lat1 = deg2rad(lat1);
    lon1 = deg2rad(lon1);
    lat2 = deg2rad(lat2);
    lon2 = deg2rad(lon2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rayon de la terre en kilometers%%%%%%%%%%%%%%%%%%%%%%%%%%%
    R = 6371;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FORMULE DE HAVERSINE %%%%%%%%%%%%%%%%%%%%

   deltaLat = lat2 - lat1;
   deltaLon = lon2 - lon1;
   a = sin(deltaLat/2)^2 + cos(lat1)*cos(lat2)*sin(deltaLon/2)^2;
   c = 2 * atan2(sqrt(a), sqrt(1-a));
   r = R * c;

%%%%%%%%%%%%%%%%% distance entre l'aéronef et l'antenne VHF %%%%%%%%%%%%%%%
   AltV=ELV2/3280.84;
   AltA=ELV1/3280.84;
   
   %%%%%%%%%%%%%%%%%%%DISTANCE AIR-SOL%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   distance=sqrt((AltV-AltA)^2+4*(R-AltA)*(R-AltV)*(sin(c/2)^2));
   distance2=distance/1.852;
   
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  if distance2>200
      fprintf('la distance de la liaison est hors portée de l''antenne VHF.\nla distance entre la VHF et laéronef est de %.2f NM.\n', distance2)
  else
  
   %%%%%%%%%%%%%%%%%%%%%%CHOIX DE CONDITION DE VENT DE
    %%%%%%%%%%%%%%%%%%%%%%SABLE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('Choisissez un cas:');
    disp('y''a pas de vent de sable')
    disp('vent de sable faible');
    disp('vent de sable moyen');
    disp('vent de sable élevé');
    
    choice = input('Entrez le numéro de votre choix:\n ');

    fprintf('la distance entre la VHF et l''aéronef est de %.2f NM.\n', distance2);


  LU=zeros(1,round(distance2));


  figure;hold on;
    for i=1:distance2
        
         LU(i)=20*log10(f)+20*log10(i)+37.8;
       
    end
 switch choice
      case 1
         LUtot=max(LU);
      case 2
         LUtot=max(LU)+4.1825;
      case 3
         LUtot=max(LU)+5.438;
      case 4
         LUtot=max(LU)+7.23;
     otherwise
        disp('Choix invalide! Veuillez choisir parmi les options proposées.');
 end
   pe=47;
   pr=pe-LUtot;
   if pr>-93
      fprintf('la puissance reçue par l''aéronef est de %.2f dbm.\n', pr);
   else
      fprintf('La puissance reçue n''a pas atteint le seuil de sensibilité de récepteur.\n');
   end
   %LES FIGURES DE PATHLOSS EN FONCTION DE LA DISTANCE
   x = 1:round(distance2);


   xx = linspace(x(1), x(end), 10*numel(x)); % 10 fois plus de points que x

   yy = spline(x, LU, xx);

   plot(xx, yy,'g', 'LineWidth', 2);

   legend('pathloss ouvert');
   grid on;
   xlabel('Distance de propagation (NM)');
   ylabel('Pertes de trajet (dB)');
   title('Courbe de pertes de trajet en fonction de la distance de propagation');
  end
end



