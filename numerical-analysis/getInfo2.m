function stud_info = getInfo2(name, IC, physics, chem, bio, maths, ad_maths)
  i = 1;
  while true
      name = input('name(Press E if you want to exit): ','s');

      if name=='E'
          break
      end
      IC = input('IC: ');
      physics = input('marks in physics: ');
      chem = input('marks in chemistry: ');
      bio = input('marks in biology: ');
      maths = input('marks in mathematics: ');
      ad_maths = input('marks in additional mathematics: ');
      

      
      stud_info(i).name= name;
      stud_info(i).IC = IC;
      stud_info(i).physics= physics;
      stud_info(i).chem = chem;
      stud_info(i).bio = bio;
      stud_info(i).maths = maths;
      stud_info(i).ad_maths= ad_maths;

      
     i = i+1;
  end
  disp(stud_info)
  
