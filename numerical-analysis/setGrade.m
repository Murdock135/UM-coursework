function grade = setGrade(struct_element,subject)
    student = struct_element;
    subject = subject;
    student(1).sub = subject;
    if student(1).subject >= 80
        grade = 'A';
    elseif (80>student(1).subject)&&(student(1).subject>74)
        grade = 'A-';
    elseif (student(1).subject<=74)&&(student(1).subject>=70)
        grade = 'B+';
    end
    student(1).grade = grade;
