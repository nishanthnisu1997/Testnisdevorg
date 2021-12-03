public class OlderAccountsUtility {
    public static void updateOlderAccounts() {
      // Get the 5 oldest accounts
      List<Account> oldaccounts = new List<Account>();
      oldAccounts = [SELECT Id,Name,Description FROM Account ORDER BY CreatedDate ASC LIMIT 5];
      // loop through them and update the Description field
      // 
      for (Account acct : oldAccounts) {
          System.debug(acct);
          acct.Description = 'Heritage Account';
      }
      // save the change you made
      update oldAccounts;
    }

}