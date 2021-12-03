public class AccountUtility {
    public static void viewAnnualRevenue(){
        List<Account> accountsList = [SELECT Name,AnnualRevenue FROM Account];
        For(Account acct : accountsList){
            String acctRev = acct.Name +':'+ acct.AnnualRevenue;
            System.debug(acctRev);
            
        }
    }

}