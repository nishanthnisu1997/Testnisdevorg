import { LightningElement, wire } from 'lwc';
import FNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import getContacts from '@salesforce/apex/ContactController.getContacts';
const COLUMNS = [
    { label: 'Account Name', fieldName: FNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Annual Revenue', fieldName: LNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Industry', fieldName: EMAIL_FIELD.fieldApiName, type: 'text' }
];
export default class AccountList extends LightningElement {
    columns = COLUMNS;
    @wire(getContacts)
    contacts;
}