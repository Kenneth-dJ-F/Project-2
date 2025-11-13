
clc
clear

% GPA calculator
% Getting number of courses
numCourses = input('Enter how many courses you took this semester: ');

% Input validation
while numCourses <= 0
    fprintf('Invalid input. Enter a positive number.\n')
    numCourses = input('Enter how many courses you took this semester: ');
end

% Initialize totals
totalPoints = 0;
totalUnits = 0;

% For loop
for i = 1:numCourses
    fprintf('\nCourse %d\n', i)

    % Getting units
    units = input('  Enter number of units: ');
    while units <= 0
        fprintf('  Invalid input. Enter a positive number.\n')
        units = input('  Enter number of units: ');
    end
    % Getting grade
    grade = input('  Enter letter grade (A, B, C, D, or F): ', 's');
    grade = upper(grade);
    % Checking grade validity
    while grade ~= 'A' && grade ~= 'B' && grade ~= 'C' && grade ~= 'D' && grade ~= 'F'
        fprintf('  Invalid grade. Enter A, B, C, D, or F.\n')
        grade = input('  Enter letter grade (A, B, C, D, or F): ', 's');
    end
   
    % Grade conversion
    if grade == 'A'
        gradePoints = 4;
    elseif grade == 'B'
        gradePoints = 3;
    elseif grade == 'C'
        gradePoints = 2;
    elseif grade == 'D'
        gradePoints = 1;
    else
        gradePoints = 0;
    end
    % Adding totals
    totalPoints = totalPoints + gradePoints * units;
    totalUnits = totalUnits + units;
end

% GPA calculation
GPA = totalPoints / totalUnits;
fprintf('\nOverall GPA = %.2f\n', GPA)
