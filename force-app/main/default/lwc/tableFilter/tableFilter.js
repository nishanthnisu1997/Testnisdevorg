/* eslint-disable no-console */
import { LightningElement,api } from 'lwc';

export default class TableFilter extends LightningElement {
    @api startdate;
    @api enddate;
    tablefltrhandler(event){
        event.stopPropagation();
    }
    handleForPutFilter(){
        //event.stopPropagation();
        console.log(this.startdate+'<=start date=>'+this.endDate);
        const selectEvent = new CustomEvent('tabelfilter',{
            detail:{'startdate':this.startdate,'enddate': this.enddate}
          });
        this.dispatchEvent(selectEvent);
        
    }
    cretaeddateFrom(event){     
     this.startdate = event.target.value;
    }
    cretaeddateto(event){
        this.enddate = event.target.value;
    }
}