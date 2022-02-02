function gradesTable = markProcessor(studentMarks)
    studentMarks = studentMarks;
    
    for i=1:numel(studentMarks)
        if studentMarks(i).physics
        gradePhysics = studentMarks(i).physics
