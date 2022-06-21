clc
clear
fprintf(2,'Universidad de las Fuerzas Armadas ESPE ');
fprintf('\nTransferencia de Masa');

%Ingreso de nombres
prompt = '\n\nIngrese el nombre de los componentes en difusión A+B: ';
txtAB = input(prompt,'s');
clc
fprintf('\nDifusión de  %s\n',txtAB);
%Ingreso de la temperatura del sistema
fprintf('\nIngrese y elija las opciones de temperatura');
fprintf('\n\t1. Grados Centigrados');
fprintf('\n\t2. Grados Kelvin');
fprintf('\n\t3. Grados Fahrenheit');
fprintf('\n\t4. Grados Rankine');
indice = input('\nEnter a number: ');

switch indice
    case 1
        clc
        tempS = input('\nIngrese el valor de temperatura (Centigrados): ');
        tempSFinal=tempS+273;
    case 2
        clc
        tempS = input('\nIngrese el valor de temperatura (Kelvin): ');
        tempSFinal=tempS;
    case 3
        clc
        tempS = input('\nIngrese el valor de temperatura (Fahrenheit): ');
        tempSFinal=((tempS+459.59)*5/9);
    case 4
        clc
        tempS = input('\nIngrese el valor de temperatura (Fahrenheit): ');
        tempSFinal=(tempS*5/9);

    otherwise
        disp('Lo sentimos no existe ese valor en el menú, por favor vuelve a intentar')       
end
clc
%Ingreso de componentes mezcla
%Viscosidad de la solución
fprintf(2,'\n\tIngrese la viscosidad de la solución: ');
viscoSoluc = input('(viscosidad)--> ');


%Ingreso de factor de asociación para el disolvente
fprintf(2,'\n\tIngrese el factor de asociación para el disolvente: ');
factorDisolv = input('(factor)--> ');
clc
%Ingreso de componentes mezcla
fprintf(2,'\n\tIngrese el número de componentes de la mezcla: ');
fprintf('\nEjemplo: A+B == 2 componentes');
componentX = input('(# Componentes)--> ');

s = componentX;
H = zeros(s);

for c = 1:s
    fprintf('\nPeso molecular del componente %d: \n',c);
    H(c) = input('(g/mol) --> ');
end

clc
%Consulta de valores en tabla
%va == volumen molal del soluto en el punto de ebullición normal 
fprintf('\n¿Existen los valores de (va(m3/kmol)) en tablas?');
fprintf('\n1. Si colocar  1 ');
fprintf('\n2. No colocar  0\n');
valorTabla = input('(1/0) --> ');
if 1 == valorTabla
            clc
            fprintf('\nPor favor ingresa el valor de va:\n');
            vaTable = input('(va) --> ');
            vaResultado=0;
else
            clc
            fprintf(2,'\n\t¿Desea calcular (va) en todos los componentes?');
            fprintf('\n1. Si colocar  1 ');
            fprintf('\n2. No colocar  0\n');
            valorElecVA = input('(1/0) --> ');
            if 1==valorElecVA
                clc
                for f = 1:s
                    fprintf(2,'\n\tEn números. ¿Cuantos átomos tiene el componente? %d',f);
                    fprintf('\nEjemplo componente H20 == 2 átomos H y O ');
                    numberAtoms = input('\n(#)--> ');
                    clc
                    ss = numberAtoms;
                    HA = zeros(ss);
                    HB = zeros(ss);
                    for e = 1:s
                        for d = 1:ss  
                            fprintf('\nComponente %d: ',e)
                            fprintf(2,'\nEscriba el nombre/inicial del átomo %d: \n',d);
                            HA(d) = input('(Atomo) --> ','s');
                            fprintf(2,'\nEn números. ¿Cuántos átomos hay? del átomo %d: \n',d);
                            HB(d) = input('(Atomo) --> ');
                        end
                    end
                end
            else
                clc
                fprintf('\nElija el número de componentes (va):\n ');
                numberForVA = input('(#)--> ');
                clc
                fprintf(2,'\n\tEn números. ¿Cuantos átomos tiene el componente? %d',numberForVA);
                fprintf('\nEjemplo componente H20 == 2 átomos H y O ');
                numberAtoms = input('\n(#)--> ');
                clc
                ss = numberAtoms;
                HA = zeros(ss);
                HB = zeros(ss);
                    for e = 1:1:numberForVA
                        for d = 1:1:ss  
                            fprintf('\nComponente %d: ',e)
                            fprintf(2,'\nEscriba el inicial del átomo %d: \n',d);
                            HA(d) = input('(Atomo) --> ','s');
                            fprintf(2,'\nEn números. ¿Cuántos átomos hay? del átomo %d: \n',d);
                            HB(d) = input('(Atomo) --> ');
                            fprintf(2,'\nIngrese el valor volumen molal de tablas para el átomo %d: \n',d);
                            HC(d) = input('(#) --> ');
                        end
                    end
                %resultado de va
                ind=1:ss;
                vaRes(ind)=HB(ind).*HC(ind);
                vaResultado=sum(vaRes);
            end
end

if vaResultado==0
    vaResultado=vaTable
else
    vaResultado
end

%resultado de va
fprintf('\nEl resultado de va es: ')
vaResultado

%Pasos de la gráfica
pasos=1;
temperatura=0:pasos:tempSFinal;

%resultado DAB
k1=117.3*10^-18;

DAB=(((k1).*(((factorDisolv).*H(2))^0.5).*temperatura)/((viscoSoluc)*((vaResultado)^0.6)));

DABResult=(((k1).*(((factorDisolv).*H(2))^0.5).*tempSFinal)/((viscoSoluc)*((vaResultado)^0.6)))

plot(temperatura,DAB)
grid on
xlabel('Temperatura (K)')
ylabel('DAB');
title(txtAB)
legend(txtAB)
