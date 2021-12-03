public with sharing class task {

    @AuraEnabled(cacheable=true)
 
    public static List<Account> acnts(){
        return [SELECT Name,Industry,Phone,Type FROM Account];
    }
    @AuraEnabled
    public static void delAcnts(string acrecId){
        Account acc= [SELECT Name,Industry,Phone,Type FROM Account WHERE Id=:acrecId];
    delete acc;
               
    }
    @AuraEnabled
    public static void delAcntsCheck(List<string> acrecId2){
     List<Account> selacc = new List<Account>();

        for(String rec:acrecId2 ){
        Account acc= [SELECT Name,Industry,Phone,Type FROM Account WHERE Id=:rec];
        selacc.add(acc);
        }
    delete selacc;
               
    }
    @AuraEnabled
    public static List<Contact> relatescontact(Id Accid){
        return [SELECT FirstName,LastName FROM Contact WHERE AccountId=:Accid];
    }
}