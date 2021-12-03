public class classautocom {
 
 public List<String> listOfStrings {get; set;}
 
   //Constructor
   public classautocom() {
      listOfStrings = new List<String>();
      for(Account a: [SELECT id, Name From Account])
      listOfStrings.add(a.name);
      }
}