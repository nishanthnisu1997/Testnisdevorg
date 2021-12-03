import { LightningElement,api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Recordeditinline extends LightningElement {
  @api recordid;
  @api objectname;
  @api fieldname;  
  @track innerloderopen = true;
onloaddatahand(){     
    this.innerloderopen = false;
}
handleSuccess(event){    
  this.showToast( 'Success', event.detail.apiName + ' Updated Successfully.', 'success');
  this.dispatchEvent(new CustomEvent('closeupdatepopup', { detail: {eventtypebutton:'Success',editrecodid:this.recordid,edittdname:this.fieldname} }));    
}
handleError(event) {
  try{    
    let errorarray = event.detail.output.fieldErrors;      
    this.showToast('Error',errorarray[this.fieldname][0].message, 'error');    
  }catch(e){
    console.log('==err0r===>'+e);
  }
}
handleClickCancel(event){
  this.dispatchEvent(new CustomEvent('closeupdatepopup', { detail: {eventtypebutton:'Cancel',editrecodid:this.recordid,edittdname:this.fieldname} }));
}    
showToast(theTitle, theMessage, theVariant) {
    const event = new ShowToastEvent({
        title: theTitle,
        message: theMessage,
        variant: theVariant
    });
 this.dispatchEvent(event);
}
stophidechlcomp(event){
  event.stopPropagation();
}
}