public class insertAccount {
    public static List<Account> insertacc(integer num){
        List<Account> act = new List<Account>();
            for(integer i=0;i<num;i++){
                        Account acc = new Account();
                acc.Name ='Acc Name' + i;
     act.add(acc);
            }
        insert act;
       return act;
    }

}