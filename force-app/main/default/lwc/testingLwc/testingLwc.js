import { LightningElement, track, api } from 'lwc';
import acnts from '@salesforce/apex/task.acnts';
import delacnts from '@salesforce/apex/task.delAcnts';
import delacntscheck from '@salesforce/apex/task.delAcntsCheck';


import ACCOUNT_OBJECT from '@salesforce/schema/Account';
//import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import { refreshApex } from '@salesforce/apex';


export default class HelloWorld extends LightningElement {
    @track objectApiName = ACCOUNT_OBJECT;
    @track accountstore = [];
    @api selectedrecId = [];
    @api tabval = 'Account';
    @track error;
    @api recordId;
    @api accountrecId;


    @api recId = '';
    @api showNew = false;
    showEdit = false;

    connectedCallback() {
        acnts()
            .then(result => {
                this.accountstore = result;
            })
            .catch(error => {
                this.error = error;
                this.contacts = undefined;
            });
        console.log(this.recordId);
    }
    handleNew() {
        this.showNew = true;
    }
    handleClose() {
        this.showNew = false;
        this.showEdit = false;

    }
    handletab() {
            this.tabval = 'Account';
        }
        /*   handleSuccess(event) {
               this.showNew = false;
               const toastEvent = new ShowToastEvent({
                   title: 'Success!',
                   message: event.detail.id,
                   variant: 'success'
               });
               this.dispatchEvent(toastEvent);
               this.AccountrecId = event.detail.id;
               console.log(event.detail.value);



               return refreshApex(this.accountstore);

           }
           handleSuccesscon(event) {
               const toastEvent = new ShowToastEvent({
                   title: 'Success!',
                   message: event.detail.id,
                   variant: 'success'
               });
               this.dispatchEvent(toastEvent);
           }*/

    handleEdit(event) {
        this.recId = event.target.value;
        console.log(this.recId);
        this.showEdit = true;

    }
    handleDelete(event) {
        this.recId = event.target.value;
        console.log(this.recId);
        delacnts({ acrecId: this.recId })
            .then(() => {
                window.location.reload();
            })
            .catch(error => {
                this.error = error;
                console.log('unable to delete');
            });
    }
    handleAccSave() {
        this.tabval = 'Related Contact';

    }

    handleEditSuccess() {
        this.showEdit = false;
        window.location.reload();
    }
    handleSelect(event) {
        this.selectedrecId.push(event.target.value);
        // this.selectedrecId.push(event.currentTarget.dataset.accountid);
        console.log(this.selectedrecId);

    }
    handleacctId(event) {
        this.accountrecId = event.detail.accountrecId;
        console.log('AccountrecId' + this.accountrecId);
    }
    handleDeleteCheck() {
        console.log(this.selectedrecId);
        delacntscheck({ acrecId2: this.selectedrecId })
            .then(() => {
                window.location.reload();
            })
            .catch(error => {
                this.error = error;
                console.log('unable to delete');
            });
    }
}