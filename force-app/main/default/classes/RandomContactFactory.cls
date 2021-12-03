public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer num, String lastname){
        List<Contact> con = new List<Contact>();
        for(integer i=1;i<=num;i++){
            Contact ct = new Contact();
            ct.FirstName='Test'+i;
            ct.LastName=lastname;
            con.add(ct);
        }
     return con;   

    }
}