public class ContactSearch {
    public static List<Contact> searchForContacts(String name1, String name2){
        List<Contact> con =[SELECT Name,Id FROM Contact WHERE LastName =:name1 OR MailingPostalCode = :name2];
        System.debug(con);
        return con;        
    }

}