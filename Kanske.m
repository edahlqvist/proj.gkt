% A=butan B=buten H=v�te W=vatten
clear
clc
clf
e=0;
Wtot=2000; %kg cat
XA_start=0;
T0=850; %K
FA0=100; %mol/s
FB0=0;
FW0=10*FA0;

HR=116.3e3; %J/mol
P=1; %bar
CP=[1.39 0.3847 -1.846e-04 2.895e-08;
    16.05 0.2804 -1.091e-04 9.098e-09;
    27.14 0.009274 -1.3813e-05 7.645e-09; 
    32.24 0.001924 1.055e-05 -3.596e-09]; %matris med alla CP konstanter J/mol/K

while XA_start-0.95<1e-2
[W,Y]=ode15s(@(W,Y)ode_func(W,Y,HR,P,CP,FA0,FB0,FW0),[0 Wtot],[XA_start T0]);

XA=Y(:,1); T=Y(:,2);

plot(W,XA, ''), hold on
xlabel('amount catalyst(kg)')
ylabel('XA')

XA_start=max(XA);
FA=(FA0)*(1-XA_start); FB=FB0+FA0*XA_start; FH=FA0*XA_start; FW=FW0;
Ftot=FA+FB+FH+FW;
FA0=FA; %mol/s
FB0=FB;
FW0=10*FA0;
e=e+1;
leg(e,:)= "reaktor "+ e;

end
legend(leg)
disp("reaktorer: "+e)


%figure(1)
%plot(W,XA, ''), hold on
%xlabel('amount of catalyst(kg)')
%ylabel('XA')

%figure(2)
%plot(T,XA, 'blue'), hold on
%xlabel('Temp(K)')
%ylabel('XA')





