public class Subject {
     
    
     public static void getMarks(Map<String,Integer> stdName){
     String subName;
     Integer Marks;
     Map<String, Integer> subList =new Map<String, Integer>();
        for(String a : stdName.keyset()){
            
             system.debug('Name : '+a+' '+'Std : '+stdName.get(a));
            
        for(Integer i=0;i<3;i++){
           
            subName = 'Sub'+i;
            Marks = 79;
            subList.put(subName, Marks);
             
            
        }system.debug(subList);
       } 
    }
}