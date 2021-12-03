public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String name){
        List<List<sObject>> searchlist =[FIND :name IN NAME FIELDS RETURNING Contact(FirstName,LastName),Lead(FirstName,LastName)];
        system.debug(searchlist);
        return searchlist;
    }
}