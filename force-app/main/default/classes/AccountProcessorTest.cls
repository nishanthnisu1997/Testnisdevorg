@isTest
private class AccountProcessorTest {
    @isTest
        static  void testdataMethod(){
            List<Id> strid = new List<Id>();
            List<Contact> conList = new  List<Contact>();
            Account acc = new Account(Name = 'Test data');
                                    insert acc ;
            for(integer i = 0;i<3;i++){
                  Contact con = new Contact();
            con.LastName = 'Test data'+ i;
            con.AccountId = acc.Id;  
                conList.add(con);
            }
strid.add(acc.Id);
            system.debug(acc.Id);
            insert conList ;
            Test.startTest() ;
        AccountProcessor.countContacts(strid);
            Account act = [Select Id,Number_Of_Contacts__c From Account][0];
            system.debug(act);
        // System.assertEquals(3, act.Number_Of_Contacts__c);
             Test.stopTest();
        }}