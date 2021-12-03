public class practice {
    List<Account> b;
    public List<Account> getacts(){
    return b;
    }
    public pagereference acccc(){
        b = [SELECT Name,Type from Account];
        return null;
    }
}