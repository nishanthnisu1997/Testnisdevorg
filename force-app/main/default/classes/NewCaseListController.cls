public class NewCaseListController {
    Public List<Case> getNewCases(){
        List<Case> result = Database.query('SELECT ID, CaseNumber FROM Case WHERE Status = \'New\'');
            return result;
    }

}