import { LightningElement, track } from 'lwc';
import acnts from '@salesforce/apex/task.acnts';
import NAME from '@salesforce/schema/Account.Name'


const COLUMN = [{ label: 'Name', fieldName: NAME.fieldApiName, type: 'text' }];

export default class HelloWorld extends LightningElement {
    //  name = "Nishanth";
    // areDetailsVisible = false;
    column = COLUMN;
    @track accountstore = [];
    @track error;

    connectedCallback() {
        acnts()
            .then(result => {
                this.accountstore = result;
            })
            .catch(error => {
                this.error = error;
                this.contacts = undefined;
            });
    }

    /*   handleChange(event) {
           this.areDetailsVisible = event.target.checked;
       }
       contacts = [{
               Id: 1,
               Name: 'Amy Taylor',
               Title: 'VP of Engineering',
           },
           {
               Id: 2,
               Name: 'Michael Jones',
               Title: 'VP of Sales',
           },
           {
               Id: 3,
               Name: 'Jennifer Wu',
               Title: 'CEO',
           },
       ];*/
}