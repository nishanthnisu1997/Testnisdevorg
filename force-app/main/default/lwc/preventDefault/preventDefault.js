import { LightningElement, track, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
//import insertAccountMethod from '@salesforce/apex/AccountinsertionusingLWC.insertAccountMethod';
import accName from '@salesforce/schema/Account.Name';
import accPhone from '@salesforce/schema/Account.Phone';
import accType from '@salesforce/schema/Account.Type';
import accWebsite from '@salesforce/schema/Account.Website';
import accSite from '@salesforce/schema/Account.Site';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class InsertAccountLwc extends LightningElement {
    @track accountname;

    @track error;
    @track arrAcc = [];
    @track gettabRecord = {
        Name: accName,
        Phone: accPhone,
        Type: accType,
        Website: accWebsite,
        Site: accSite

    };
    @track getAccountRecord = {
        Name: accName,
        Phone: accPhone,
        Type: accType,
        Website: accWebsite,
        Site: accSite

    };
    @track PicklistValues;
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: accType })
    contacts({ data, error }) {
        if (data) {
            this.picklistvalues = data.values;
        }
        if (error) {}
    }


    nameInpChange(event) {
        this.getAccountRecord.Name = event.target.value;
        //window.console.log(this.getAccountRecord.Name);
    }

    phoneInpChange(event) {
        this.getAccountRecord.Phone = event.target.value;
        //window.console.log(this.getAccountRecord.Phone);
    }

    typeInpChange(event) {
        this.getAccountRecord.Type = event.target.value;
        //window.console.log(this.getAccountRecord.Type);
    }

    websiteInpChange(event) {
        this.getAccountRecord.Website = event.target.value;
        //window.console.log(this.getAccountRecord.Type);
    }

    accSiteChange(event) {
        this.getAccountRecord.Site = event.target.value;
        //window.console.log(this.getAccountRecord.Type);
    }
    saveAccountAction() {
        console.log("inside");
        console.log('getAccountRecord' + this.getAccountRecord);
        //this.gettabRecord = this.getAccountRecord;
        this.arrAcc.push(this.getAccountRecord);
        console.log('gettabRecord' + this.getAccountRecord);
        console.log('arrAccw' + this.arrAcc);
        this.getAccountRecord = {};

    }
    handleRemove(event) {
        this.accountname = event.target.value;
        this.arrAcc.splice(-1, 1);
    }
}