trigger ContactTrigger on Contact (before insert) {
    Contact a = Trigger.new[0];
    a.FirstName=a.FirstName +'bro';

}