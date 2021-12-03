import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ChildComponenentContact extends LightningElement {
    @api accrecId;
    handleSuccesscon(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: event.detail.id,
            variant: 'success'
        });
        this.dispatchEvent(toastEvent);
    }
}