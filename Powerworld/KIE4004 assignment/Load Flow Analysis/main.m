clear
close
clc

met = input('Enter the method for load flow (1 - Newton-Raphson, 2 - Fast Decouple): ');
while met ~= 1 && met ~= 2
    fprintf('Invalid Input try again\n');
    met = input('Enter the method for load flow (1 - Newton-Raphson, 2 - Fast Decouple): ');
end

switch met
    case 1
        nrlfppg
    case 2
        dclfppg
end