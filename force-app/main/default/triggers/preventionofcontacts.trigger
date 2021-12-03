trigger preventionofcontacts on Contact (before delete) {
    for (Contact con : Trigger.old){
        if(con.Active__c== True)
            con.adderror('active contact should be deleted');
    }

}