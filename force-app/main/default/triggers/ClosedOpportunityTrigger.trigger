trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<Task> tasklist = new List<Task>();
    for(Opportunity opps : trigger.new){
        if(opps.StageName=='closed Won' ){
            Task t = new Task();
            t.Subject='Follow Up Test Task';
            t.WhatId = opps.Id;
            tasklist.add(t);
            
        }
    }insert taskList;
}