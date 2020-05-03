clc,clear;
format shortG

%%Konstanter
% Molmassa f�r komponenterna
M=[58.12*10^-3;
   56.1*10^-3;
   2*1.00784*10^-3;
   18.01528*10^-3];                                 %Butan-Buten-H2-H2O i kg/mol

%Specifika v�rmekapaciteterna f�r komponenterna
CP=[1.39 0.3847 -1.846e-04 2.895e-08;
    16.05 0.2804 -1.091e-04 9.098e-09;
    27.14 0.009274 -1.3813e-05 7.645e-09;
    32.24 0.001924 1.055e-05 -3.596e-09];           %Butan-Buten-H2-H2O i J/mol/K

C=0.8;                                              %temperaturverkningsgrad f�s fr�n kurs PM

%%V�rmev�xling fl�de 12
%molfl�de f�r fl�de 12 (varmt)
F_mol=[11.5002;
       42.9998;
       42.4998;
       540.0000];                                   %Butan-Buten-H2-H2O i mol/s

%Butan-Buten-H2-H2O i kg/s       
F_massa=[F_mol(:,1).*M(:,1)];                        %Butan-Buten-H2-H2O i kg/s 
     
%Temp f�r fl�de 12 

TH_in=936;  TH_ut=323; TH_medel=(TH_in+TH_ut)/2;    %Temp i Kelvin

%Cp f�r componenter i fl�de 12

CP_flow_12=[Cp(TH_medel,CP(1,1),CP(1,2),CP(1,3),CP(1,4),M(1));
            Cp(TH_medel,CP(2,1),CP(2,2),CP(2,3),CP(2,4),M(2));
            Cp(TH_medel,CP(3,1),CP(3,2),CP(3,3),CP(3,4),M(3));
            Cp(TH_medel,CP(4,1),CP(4,2),CP(4,3),CP(4,4),M(4))];  %CP for flow 12 i J/Kg*K

%Cp och temp f�r kalt fl�de (vatten)
TC_in=273+180;  TC_ut=1219.3; %fr�n temp f�r utfl�de kallt  
TC_medel=(TC_in+TC_ut)/2;
CP_H2O_cold=Cp(TC_medel,CP(4,1),CP(4,2),CP(4,3),CP(4,4),M(4))  %avskrider lite d� temp �r lite annrolunda (�ndringar?)

%q f�r v�rmev�xlare efter fl�de 12
q_parts=F_massa(:,1).*CP_flow_12(:,1).*(TH_in-TH_ut)     %Energi f�r upphettning
q_tot=q_parts(1)+q_parts(2)+q_parts(3)+q_parts(4)        %J/s

%Temp f�r utfl�de kallt
TC_ut=TC_in+(TH_in-TH_ut)/C
        


