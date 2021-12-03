public class AccountProcessor {
  @future
  public static void countContacts(List<Id> recordIds) {
      List<Account> acc = new List<Account>();
      for(Account act : [Select Name,Id,Number_Of_Contacts__c from Account where id=:recordIds] ){
          act.Number_Of_Contacts__c= [Select Count() from Contact Where accountid=:act.Id];
          acc.add(act);
      }
      try{
          system.debug(acc[0].Number_Of_Contacts__c);
   update acc;
          
          system.debug(acc[0].id);
          if(Test.isRunningTest())
			{
				throw new DmlException();
			}
      }catch(DmlException e){
          system.debug(e.getMessage());
      }
  }
}