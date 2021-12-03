import { LightningElement, wire, track } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName'
import LAST_NAME from '@salesforce/schema/Contact.LastName'
import EMAIL from '@salesforce/schema/Contact.Email'
import SALUTATION_FIELD from '@salesforce/schema/Contact.Salutation'
import { getPicklistValues } from 'lightning/uiObjectInfoApi';

const COLUMN = [
    { label: 'First name', fieldName: FIRST_NAME.fieldApiName, type: 'text' },
    { label: 'Last name', fieldName: LAST_NAME.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: EMAIL.fieldApiName, type: 'text' }
];

export default class TaskAwt extends LightningElement {
    @track conlist;
    show = false;
    shownew = false;
    @track values;
    @track picklistvalues;



    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: SALUTATION_FIELD })
    contacts({ data, error }) {
        if (data) {
            this.picklistvalues = data.values;
        }
        if (error) {}
    }
    handlechange() {

    }
    newaccount() {
        this.shownew = true;

    }
    close() {
        this.shownew = false;

    }

    column = COLUMN;
    /* @wire(getContacts)
     contacts({ data, error }) {
         if (data) {
             this.conlist = data;
         } else if (error) {

         }*/
    getContacts(event) {
        this.show = event.target.checked;
        getContacts().then(result => {
                this.conlist = result;
            })
            .catch(error => {

            })
    }
}