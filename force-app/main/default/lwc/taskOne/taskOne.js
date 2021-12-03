import { LightningElement, track, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import insertAccountMethod from '@salesforce/apex/AccountinsertionusingLWC.insertAccountMethod';
import accName from '@salesforce/schema/Account.Name';
import accPhone from '@salesforce/schema/Account.Phone';
import accType from '@salesforce/schema/Account.Type';
import accWebsite from '@salesforce/schema/Account.Website';
import accSite from '@salesforce/schema/Account.Site';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class InsertAccountLwc extends LightningElement {
    @track accountid;
    @track error;
    @track showRecord = false;
    @track showDate = false;
    @track showCalc = false;



    @track getAccountRecord = {
        accName: accName,
        accPhone: accPhone,
        accType: accType,
        accWebsite: accWebsite,
        accSite: accSite

    };
    @track PicklistValues;
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: accType })
    actstore({ data, error }) {
        if (data) {
            this.picklistvalues = data.values;
        }
        if (error) {}
    }


    nameInpChange(event) {
        this.getAccountRecord.accName = event.target.value;
        console.log(this.getAccountRecord.accName);
    }

    phoneInpChange(event) {
        this.getAccountRecord.accPhone = event.target.value;
        console.log(this.getAccountRecord.accPhone);
    }

    typeInpChange(event) {
        this.getAccountRecord.accType = event.target.value;
        window.console.log(this.getAccountRecord.accType);
    }

    websiteInpChange(event) {
        this.getAccountRecord.accWebsite = event.target.value;
        console.log(this.getAccountRecord.accWebsite);
    }

    accSiteChange(event) {
        this.getAccountRecord.accSite = event.target.value;
        console.log(this.getAccountRecord.accSite);
    }
    handlClick() {
        this.showRecord = true;
    }
    handlClose() {
        this.showRecord = false;
        this.showDate = false;
        this.showCalc = false;
    }
    handlClickCalc() {
        this.showCalc = true;
    }


    handlClickDate() {
        this.showDate = true;
    }
    saveAccountAction() {
        //window.console.log('before save' + this.createAccount);
        console.log(this.getAccountRecord);

        insertAccountMethod({ accountObj: this.getAccountRecord })
            .then(result => {
                //  window.console.log(this.createAccount);
                this.getAccountRecord = {};
                this.accountid = result.Id;
                window.console.log('after save' + this.accountid);

                const toastEvent = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Recordid  ' + result.Id,
                    variant: 'success'
                });
                this.dispatchEvent(toastEvent);
            })
            .catch(error => {
                //  this.error = error.message;
                window.console.log('UNABLE TO SAVE');
            });
    }


}