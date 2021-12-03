/* eslint-disable no-console */
import { LightningElement, api, track } from 'lwc';

export default class GenericTableCell extends LightningElement {
    @track cellValue;
    @track cellType;
    
    @api 
    get cellFieldName(){
        //console.log('==10==>'+this._cellFieldName);
        return this._cellFieldName;
    }
    set cellFieldName(value){
        //console.log('==14==>'+value);
        this._cellFieldName = value;
    }
    @api 
    get cellData(){
        //console.log('==19==>'+this._cellData);
        return this._cellData;
    }
    set cellData(value){
        //console.log('==23==>'+value);
        this._cellData = value;
        this.separateDateObject();
    }

    separateDateObject(){
      //console.log(this.cellFieldName+'==25=>'+this.cellData);
      this.cellValue = this.cellData[this.cellFieldName];
      //console.log('==27==>'+this.cellValue);
    }

    
}