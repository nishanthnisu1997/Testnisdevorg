public with sharing class AccountinsertionusingLWC {
 
    @AuraEnabled
    public static Account insertAccountMethod(WrapperExample accountObj){
        
            system.debug(accountObj);
            Account acobj = new Account();
            acobj.Name=accountObj.accName;
            acobj.Phone=accountObj.accPhone;
            acobj.Type=accountObj.accType;
            acobj.Site=accountObj.accSite;
            acobj.Website=accountObj.accWebsite;
            system.debug(acobj);
try{
 insert acobj;
 system.debug(acobj);

 return acobj;
        } catch (DmlException  exp) {
         throw new AuraHandledException(exp.getMessage());
         //   system.debug('The following exception has occurred:'+exp.getMessage());
        }
    }
public class WrapperExample{
    @AuraEnabled public String accName{get;set;}
    @AuraEnabled public String accPhone{get;set;}
    @AuraEnabled public String accType{get;set;}
    @AuraEnabled public String accSite{get;set;}
    @AuraEnabled public String accWebsite{get;set;}


}
}