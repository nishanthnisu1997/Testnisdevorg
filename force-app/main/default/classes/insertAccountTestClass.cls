@isTest
public class insertAccountTestClass {
      /* Account createacc = new Account();
        List<Account> lstacc = new List<Account>();
            for(integer i=0;i<5;i++){
                createacc.Name ='Acc Name' + i;
     lstacc.add(createacc);
            }*/
    @isTest static void testinset(){
        integer num = 5;
        List<Account> lstacc=insertAccount.insertacc(num);
                system.assertEquals(5, lstacc.size());

    }
    

}