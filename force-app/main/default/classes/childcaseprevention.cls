public class childcaseprevention{
    public static void fieldupdate(List<Case> CaseList){
        
    For(Case c : CaseList){
        If(c.Status=='Closed'){
            c.Origin='Web';
        }
       }
}
        public static void caseprevention(List<Case> CaseList){
             list<id>idList=new list<id>();
    for(case refid :CaseList){
        idList.add(refid.Id);
    }
       integer close =[select count() from case where parentId =:idList and isClosed != true];
            for(Case c: CaseList){
                if(c.Status=='Closed'){
if (close > 0)

{c.addError('There are still Child Cases Open - Please close and try again!');

}
}
}}
        }