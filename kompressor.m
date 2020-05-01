%Kompressorber�kningar f�r GKT-projekt
%G�ller f�r alkandehydrerings-projekten samt metanolprojektet.
%T�nk p� att endast gaser tryckh�js i kompressorer. F�r v�tskor anv�nds
%pumpar.
%Skapad av: Elin G�ransson, 2008-04-07
%
%Ber�kningar bygger p� antaganden om adiabatisk kompression och omr�kning
%med isentropverkningsgrad f�r att f� verkligt effektbehov.
%
%Kompressionen delas upp i tre steg med mellankylning pga den stora
%tryck�kningen. Uppdelningen sker s� att effektbehovet blir samma i varje
%steg, och kylningen emellan utformas s� att man f�r samma temperatur in
%till varje kompressor.
%
%Funktionen:
%[Wtot,Qkyl,Akyltot,Tut]=kompressor(Ctot,kappa,Pin,Tin,Put,eta_is)
%
%Indata:
%Ctot [W/K] = Summan av m*cp f�r alla komponenter i fl�det, d�r m �r
%             fl�det i kg/s (alt mol/s) och cp �r medelv�rmekapaciviteten
%             �ver temperaturintervallet i kompressorn i J/(kgK) (alt J/(molK)).
%kappa []   = Kappatalet (viktat medelv�rde av kappa f�r de olika
%             komponenterna)
%Pin [Pa]   = Ing�ende tryck till kompressorerna
%Tin [K]    = Ing�ende temperatur
%Put [Pa]   = Utg�ende tryck
%eta_is []  = Isentropverkningsgrad
%
%Utdata:
%Wtot [W]       = Totalt effektbehov f�r kompressionen.
%Qkyl [W]       = Kylbehov i mellankylare.
%Akyltot [m2]   = Total v�rmev�xlararea f�r mellankylare.
%Tut [K]        = Utg�ende temperatur.

function [Wtot,Qkyltot,Akyltot,Tut]=kompressor(Ctot,kappa,Pin,Tin,Put,eta_is)

%Tryck�kning per steg.
P_step = (Put/Pin)^(1/3);  %[]
%Temperatur ut fr�n varje kompressorsteg f�r isentrop kompression.
Tut_is = Tin*P_step^((kappa-1)/kappa);  %[K] 
%Verklig temperatur ut fr�n varje kompressorsteg.
Tut = Tin + (Tut_is-Tin)/eta_is; %[K] 
%Erforderlig kompressoreffekt f�r ett kompressorsteg.
W = Ctot*(Tut-Tin); %[W] 
%Total erforderlig kompressoreffekt (3 steg).
Wtot = 3*W; %[W] 
%Erforderlig kyleffekt i 1 mellankylare
Qkyl = Ctot*(Tut-Tin);%[W] 
%Total erforderlig kyleffekt i mellankylare (2 st)
Qkyltot = 2*Qkyl; %[W] 
%Kylvattnets temperatur.
Tkv = 14+273.15; %[K] 
%Maximal temperatur som kylvattnet f�r v�rmas till
Tkvmax = 20+273.15; %[K] 
%Logaritmisk medeltemperaturdifferens.
deltaTlm = ((Tin-Tkv)-(Tut-Tkvmax))/log((Tin-Tkv)/(Tut-Tkvmax)); %[]
%U-v�rde f�r mellankylare (gas-v�tska)
Ukyl = 200; %[W/(m2K)] 
%V�rmev�xlararea f�r 1 mellankylare
Akyl = Qkyl/(Ukyl*deltaTlm); %[m2] 
%Total v�rmev�xlararea f�r mellankylarna.
Akyltot = 2*Akyl; %[m2] 