clear all; close all;

opts = spreadsheetImportOptions("NumVariables", 5);

opts.Sheet = "Sheet1";
opts.DataRange = "A2:E11";

opts.VariableNames = ["Name", "IC", "Physics", "Biology", "Chemistry"];
opts.VariableTypes = ["string", "string", "double", "double", "double"];

opts = setvaropts(opts, "Name", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Name", "EmptyFieldRule", "auto");

Grade = readtable("D:\OneDrive - 365.um.edu.my\Education\Electrical Engineering\Year 3\Sem 1\KIE3005 - Numerical Analysis\Exercise\Week 4\Grade.xlsx", opts, "UseExcel", false);

for i = 1:10
    average(i) = (Grade{i,3} + Grade{i,4} + Grade{i,5})/3
    Grade{i,6} = average (i)
end

ranking = sortrows(Grade, 6, 'descend')

clc

for i = 1:10
    fprintf('Name: %s\n', ranking{i,1});
    fprintf('IC: %s\n', ranking{i,2});
    fprintf('Subject\t\t Marks \t Grade \n');
    for j = 3:5
        if ranking{i,j} >= 90
            grade(j) = "A+";
        elseif ranking{i,j} >= 80
            grade(j) ="A";
        elseif ranking{i,j} >= 75
            grade(j) ="A-";
        elseif ranking{i,j} >= 70
            grade(j) ="B+";
        elseif ranking{i,j} >=65
            grade(j) = "B";
        elseif ranking{i,j} >= 60
            grade(j) ="B-";
        elseif ranking{i,j} >= 55
            grade(j) ="C+";
        elseif ranking{i,j} >=50
            grade(j) = "C";
        elseif ranking{i,j} >= 45
            grade(j) ="C-";
        elseif ranking{i,j} >= 40
            grade(j) ="D+";
        elseif ranking{i,j} >=35
            grade(j) = "D";
        elseif ranking{i,j} <=34
            grade(j) = "F";
        end
    end
    fprintf('Physics\t\t %.2f\t %s\n', ranking{i,3}, grade(3));
    fprintf('Biology\t\t %.2f\t %s\n', ranking{i,4}, grade(4));
    fprintf('Chemistry\t %.2f\t %s\n', ranking{i,5}, grade(5));
    fprintf('Rank %d out of 10 students\n\n', i);
end

    