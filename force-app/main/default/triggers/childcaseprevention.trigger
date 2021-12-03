trigger childcaseprevention on Case (before update) {
    if(trigger.isbefore && Trigger.isupdate ){
      childcaseprevention.fieldupdate(Trigger.New);
          childcaseprevention.caseprevention(Trigger.New);

    }
}