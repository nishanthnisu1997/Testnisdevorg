public class fordisplayall {
    List<Account> sample;
        
    
    public List<Account> getsample(){
        return sample;}
    public List<Account> getsample1(){
        return sample;}
         public List<Account> getsample2(){
        return sample;
    } 
    public pagereference showall(){
        sample  = [SELECT Name, Type FROM Account];
        return null;
    }
    public pagereference showdirect(){
        sample = [SELECT Name, Type FROM Account WHERE Type='Customer - Direct'];
        return null;
    }
     public pagereference showchannel(){
        sample = [SELECT Name, Type FROM Account  WHERE Type='Customer - Channel'];
        return null;
    }
    public pagereference updation(){
         update sample;
        return null;
    }}