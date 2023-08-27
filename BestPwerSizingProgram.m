clear;
clc;

% The menu for selecting the equipment
eq = {'Blower: centrifugal', 'Compressor', 'Crystallizer: vacuum', ...
    'Dryer: drum', 'Fan: centrifugal', 'Filter: vacuum', 'Lagoon: aerated', ...
    'Motor', 'Reactor', 'Tank: horizontal'};
p = listdlg('PromptString', 'Please select the needed equipment', ...
    'SelectionMode', 'single', 'ListSize', [200 250], 'ListString', eq);

% Equipment labels and power sizing exponents
equipmentLabels = {'blower', 'compressor', 'vacuum', 'dryer', 'fan', ...
    'vacuum', 'lagoon', 'motor', 'reactor', 'tank'};
powerExponents = [0.59, 0.32, 0.37, 0.40, 1.17, 0.48, 1.13, 0.69, 0.56, 0.57];
j = equipmentLabels{p};
x = powerExponents(p);

% Capacity units menu
capacityUnits = {'Horsepower (hp)', 'Cubic Feet per Minute (ft^3/min)', ...
    'Cubic Feet (ft^2)', 'Gallons (gal)', 'Gallons per Day (gal/day)'};
G = menu('Capacity Units', capacityUnits);

z = capacityUnits{G};

% Input dialog box for cost and sizes
prompt = {'Cost of equipment:', 'Size/capacity of the initial equipment:', 'Size/capacity of the NEW equipment:'};
dlgtitle = 'Input Pane';
dims = [1 35];
answer = inputdlg(prompt, dlgtitle, dims);
C_B = str2double(answer{1});
S_B = str2double(answer{2});
S_A = str2double(answer{3});

% Calculate cost for given equipment and units
C_A = ((S_A / S_B) ^ x) * C_B;

% Calculate cost difference
costDifference = C_A - C_B; % Don't use absolute value here

% Calculate percentage increase or decrease
if C_B == 0
    percentageChange = 0;  % Avoid division by zero
else
    percentageChange = ((C_A - C_B) / C_B) * 100;
end

% Determine if cost increased or decreased
if costDifference > 0
    costChange = ['increase of $', num2str(costDifference), ' (', num2str(percentageChange), '%)'];
elseif costDifference < 0
    costChange = ['decrease of $', num2str(-costDifference), ' (', num2str(percentageChange), '%)'];
else
    costChange = 'no change';
end

% Display result in a message box
if G == 1
    u = 'hp';
elseif G == 2
    u = 'ft^3/min';
else
    u = equipmentLabels{p};
end

Y = sprintf('The cost of the %.2f %s %s will cost $%.2f\n\nThis is a %s in cost.', S_A, u, j, C_A, costChange);
h = msgbox(Y);
