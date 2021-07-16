clear 
clc

%The menu for selecting the equipment
eq = {'Blower: centrifugal', 'Compressor', 'Crystallizer: vacuum'...
    ,'Dryer: drum','Fan: centrigufal','Filter: vacuum','Lagoon: aerated'...
    ,'Motor','Reactor','Tank: horizontal'};
p = listdlg('PromptString',{'Please select the needed equipment',...
    ''},...
    'SelectionMode','single','ListSize',[200 250],'ListString',eq);

%The if statement that will convert selection from Line 8 into a string
if p == 1 
    j = "blower";
elseif p == 2
    j = "compressor";
elseif p == 3
    j = "vacuum";
elseif p == 4
    j = "dryer";
elseif p == 5
    j = "fan";
elseif p == 6
    j = "vacuum";
elseif p == 7
    j = "lagoon";
elseif p == 8
    j = "motor";
elseif p == 9 
    j = "reactor";
else p == 10;
    j = "tank";
end 
    
%The if statement that will assign the power sizing exponent
if p == 1
    x = 0.59;
elseif p == 2
    x = 0.32;
elseif p == 3
    x = 0.37;
elseif p == 4
    x = 0.40;
elseif p == 5 
    x = 1.17;
elseif p == 6
    x = 0.48;
elseif p == 7
    x = 1.13;
elseif p == 8
    x = 0.69;
elseif p == 9
    x = 0.56;
else p == 10;
    x = 0.57;
end 

%The menu that asks for the units
G = menu('Capacity Units','Horsepower (hp)','Cubic Feet per Minute (ft^3/min)','Cubic Feet (ft^2)','Gallons (gal)','Gallons per Day (gal/day)','Other');

%The if statement that will convert selection from Line 40 into a string
if G == 1
    u = "hp";
elseif G == 2
    u = "ft^3/min";
elseif G == 3
    u = "cubic foot";
elseif G == 4
    u = "gallon";
elseif G == 5
    u = "gal/day";
else G == 6; 
    t = menu('We will have to convert your current units into one of the previous given units from the menu before. Click Ok to then type what your units are.','Ok'); 
        if t == 1
            Ff = inputdlg('Input your units: ','Conversion Pane');
        end  

    z = upper(Ff);
    
    %The input dialog box that will ask for user input for 
    prompt = {'Cost of equipment: ', 'Size/capacity of the inital equipment: ', 'Size/capacity of the NEW equipment: '};
    dlgtitle = 'Input Pane';
    dims = [1 35];
    answer = inputdlg(prompt,dlgtitle,dims);
    
    r = str2num(answer{1}) && str2num(answer{2});

    %This first if statement tackles POWER conversions
    if strcmp(z, 'WATT') == 1 || strcmp(z, 'WATTS') == 1 || strcmp(z,'W') == 1 || strcmp(z,'J/S') == 1 || strcmp(z,'JOULE PER SECOND') == 1 || strcmp(z,'JOULE/SECOND') == 1
        o = r / 745.701033542;
        u = "hp";
    %The next six elseif statements tackles VOLUMETRIC FLOW RATE conversions
    elseif strcmp(z,'M^3/S') == 1 || strcmp(z,'CUBIC METERS PER SECOND') == 1
        o = r / 2118.88199311;
        u = "ft^3/min";
    elseif strcmp(z,'FT^3/S') == 1 || strcmp(z,'CUBIC FOOT PER SECOND') == 1 || strcmp(z,'CUBIC FEET PER SECOND') == 1
        o = r / 60;
        u = "ft^3/min";
    elseif strcmp(z,'LITER PER SECOND') == 1 || strcmp(z,'L/S') || strcmp(z,'LITERS PER SECOND')
        o = r / 2.11881993;
        u = "ft^3/min";
    elseif strcmp(z,'LITER PER MINUTE') == 1 || strcmp(z,'LITERS PER MINUTE') == 1 || strcmp(z,'L/MIN') == 1
        o = r / 0.03531472483;
        u = "ft^3/min";
    elseif strcmp(z,'MILLITER PER SECOND') == 1 || strcmp(z,'ML/S') || strcmp(z,'MILLITERS PER SECOND')
        o = r * 471.947;
        u = "ft^3/min";
    elseif strcmp(z,'MILLITER PER MINUTE') == 1 || strcmp(z,'MILLITERS PER MINUTE') == 1 || strcmp(z,'ML/MIN') == 1
        o = r * 28316.8;
        u = "ft^3/min";
    %The next X elseif statements tackles VOLUME conversions    
    elseif strcmp(z,'CUBIC YARDS') == 1 || strcmp(z,'YD^3') == 1 || strcmp(z,'YDS^3') == 1 || strcmp(z,'YARDS CUBED') == 1
        o = r * 27; 
        u = "cubic foot";
    elseif strcmp(z,'CUBIC METERS') == 1 || strcmp(z,'M^3') == 1 || strcmp(z,'METERS CUBED') == 1
        o = r * 35.3147;
        u = "cubic foot";
    elseif strcmp(z,'CUBIC CENTIMETERS') == 1 || strcmp(z,'CM^3') == 1 || strcmp(z,'CENTIMETERS CUBED') == 1
        o = r / 28316.8;
        u = "cubic foot";
    elseif strcmp(z,'CUBIC MILLIMETERS') == 1 || strcmp(z,'MM^3') == 1 || strcmp(z,'MILLIMETERS CUBED') == 1
        o = r / 2.83168*10^7;
    elseif strcmp(z,'LITERS') == 1 || strcmp(z,'L') == 1 || strcmp(z,'LITER') == 1
        o = r / 28.31681991;  
        u = "cubic foot";
    end   
    
    %Convert selections from strings to numbers so that we can calculate
    C_B = str2num(answer{1});
    S_B = str2num(answer{2});
    S_A = str2num(answer{3});

    %The power sizing equation
    C_A = (((S_A)/(S_B)).^(x))*(C_B);

    %Declaration based on all given inputs from above
    Y = sprintf('The cost of the %.3f %s %s will cost $%.2f\n\n', o, u, j, C_A);

    %Final message box
    h = msgbox(Y);
end 
 
%The input dialog box that will ask for user input for 
prompt = {'Cost of equipment: ', 'Size/capacity of the inital equipment: ', 'Size/capacity of the NEW equipment: '};
dlgtitle = 'Input Pane';
dims = [1 35];
answer = inputdlg(prompt,dlgtitle,dims);

%Convert selections in Line 59 from strings to numbers so that we can
%calculate
C_B = str2num(answer{1});
S_B = str2num(answer{2});
S_A = str2num(answer{3});

%The power sizing equation
C_A = (((S_A)/(S_B)).^(x))*(C_B);

%Subtraction
K = abs(C_A - C_B);

%Declaration based on all given inputs from above
Y = sprintf('The cost of the %.2f %s %s will cost $%.2f\n\nThis is a difference of $%.2f', S_A, u, j, C_A,K);

%Final message box
h = msgbox(Y);
