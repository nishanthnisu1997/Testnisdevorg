public class Student {
    public String name;
    public Integer standard;
    
   
    Map<String,Integer> studName = new Map<String,Integer>();
 
    public void  getname(){
    for(Integer i=0;i<4;i++){
        name= 'name'+i;
        standard = 5;
        studName.put(name,standard);
    }
        Subject.getMarks(studName);
    }
}