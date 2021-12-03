public class accountcreation{
              public Account s {get;set;}
    Public accountcreation(){
                s=new Account();
    }

    public pageReference save(){
        insert s;
        Return new pageReference('/'+s.Id);
    }
}