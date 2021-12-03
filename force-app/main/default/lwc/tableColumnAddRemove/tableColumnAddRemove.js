/* eslint-disable no-console */
import {
    LightningElement,
    wire,
    api
} from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
//import {fireEvent} from 'c/pubsub';
export default class TableColumnAddRemove extends LightningElement {
    @api columnManuSelect;
    @wire(CurrentPageReference) pageRef;
    TableColumnAddRemove(){
        //console.log('==callCouns=>0');
    }
    
    connectedCallback(){
        //console.log('==callCouns=>2'+this.columnManuSelect);
    }
    
    showhidecolumnhandler(event){      
      var columnManuSelectdata = [];
      var selecttf;
      var currentshowhide;
      var columnName;
      var clmvaluename = event.target.title;
      var indexval =0;
      var selectedcolmindx;
      ////console.log('==callCouns=>2'+JSON.stringify(this.columnManuSelect));  
      ////console.log('==current==>'+event.target.title);
      this.columnManuSelect.forEach(function(selectedItem) {
         ////console.log('==callCouns=>19'+JSON.stringify(selectedItem)); 
         selecttf = selectedItem.show;
         if(selectedItem.key === event.target.title && selectedItem.show === true){
            //console.log(selectedItem.show+'==cur11rent==>'+selectedItem.key);
            columnName = selectedItem.value;
            selectedcolmindx=indexval;
            currentshowhide =false;
            selecttf = false;
         }
         
         if(selectedItem.key === event.target.title && selectedItem.show === false){
            //console.log(selectedItem.show+'==cur22rent==>'+selectedItem.key);
            columnName = selectedItem.value; 
            selectedcolmindx=indexval;           
            selecttf = true;
            currentshowhide =true;
         }         
         columnManuSelectdata.push({value:selectedItem.value, key:selectedItem.key, show:selecttf,indexelm:indexval}); 
         indexval++;        
      });
      this.columnManuSelect = columnManuSelectdata;
      //console.log('==callCouns=>3'+JSON.stringify(this.columnManuSelect)); 
      //this.dispatchEvent(new CustomEvent('searchKeyChange',{}));
      const selectEvent = new CustomEvent('tabelcolumnshowhide',{
          detail:{'Allcolm':this.columnManuSelect,'columnName': columnName,'clmvaluename': clmvaluename,'clmshowhide': currentshowhide,'indexval':selectedcolmindx}
        });
      this.dispatchEvent(selectEvent);
      //fireEvent(this.pageRef, 'tabelcolumnshowhide', this.columnManuSelect);
    } 
    
}