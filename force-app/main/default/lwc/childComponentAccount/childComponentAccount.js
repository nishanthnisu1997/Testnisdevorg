import { LightningElement, track, api } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class ChildComponentAccount extends LightningElement {
    @api objectApiName = ACCOUNT_OBJECT;
    @api showNew;
    @api tabval;
    @api accountrecId;
    handleSuccess(event) {
        this.showNew = false;
        const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: event.detail.id,
            variant: 'success'
        });
        this.dispatchEvent(toastEvent);
        const customEvt = new CustomEvent("acctid", {
            detail: {
                accountrecId: event.detail.id
            }
        });
        this.dispatchEvent(customEvt);
        //   this.AccountrecId = event.detail.id;
        //    console.log(event.detail.value);



        // return refreshApex(this.accountstore);

    }
    handleNew() {
        this.showNew = true;
    }
    handleClose() {
        this.showNew = false;

    }
    handleAccSave() {
        this.tabval = 'Related Contact';

    }
}