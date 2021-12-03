@isTest
private class TestRestrictContactByName {
    @isTest static void testcontact(){
        // create contact 
        Contact con = new contact();
        con.LastName='INVALIDNAME';
        Database.Saveresult res = Database.insert(con,false);
        System.assertEquals('The Last Name "'+con.LastName+'" is not allowed for DML', res.getErrors()[0].getMessage());
    } 

}