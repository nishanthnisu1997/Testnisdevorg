/* eslint-disable no-unused-vars */
/* eslint-disable guard-for-in */
/* eslint-disable no-console */
import { LightningElement,wire, track, api } from 'lwc'; 
import getObjectsDetailList from '@salesforce/apex/ComvTable.ManageRecordsController.getObjectsDetailList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class RecordList extends LightningElement { 
   @api allDataSet; 
   @api refreshcash;
   @track accounts;  
   @track error;  
   @track currentpage = 1;
   @track totalPages;  
   @api pagesize;  
   @track searchKey;
   @track tableHeadName;
   @track loading = true;  
   localCurrentPage = null;  
   isSearchChangeExecuted = false; 
   @track fieldsLable
   finalfieldsLable;
   @track fieldsApiName;
   @track fieldsRecordsdata=[];
   @track Recordsdata;
   @track selectedrecords;
   @track recordsDatacount;
   @track ColumnSearchEnable
   paginationEnable
   ShortingEnable
   InlineEditEnable
   SelectRowAction
   GlobalSearchEnable
   ColumnShowHideMenu
   GlobalFilterEnable;
   @track columnManuSelect=[];
   @track fildNameWithType;
   @track recordsPerPage;
   @track showLastButton;
   @track searchableAllFields;
   @track FieldsInlineEdit;
   @track filtereddata;
   @track AllData;
   @track showColumnMenu =false;
   @track tableFilterMenu =false;
   @track startindex=0;endindex;
   @track datasearchkey='';
   @track componenttName;
   @track columnsearchSLDS ='slds-truncate slds-hide searchInput';
   @track paginationItems = [];
   @track columnsearchavalbl=false;
   @track startdate;
   @track enddate;
   @track sortfieldName;
   @track sortType;
   fixedWidth = "width:15rem;";
   @track initialRender = true;
   @track showselectedtype = 'selectallrecord';
   @track editrecodid = '';
   @track edittdname = '';
   @track closeupdatepopupval = false;
   @track innerloderopen = true;
   @track objectname;   
   @track selectedrecordids=[];
   sortcurrenttarget;
   @api
   get isascdsc(){
     return this.sortType;
   }
   
   get loderopen(){
     if(this.loading){
      return true;
     }
      return false;
   }
   get showFirstButton() {  
    if (this.currentpage === 1) {  
      return true;  
    }  
    return false;  
   }

RecordList(){
} 
showToast(theTitle, theMessage, theVariant) {
  const event = new ShowToastEvent({
      title: theTitle,
      message: theMessage,
      variant: theVariant
  });
this.dispatchEvent(event);
}
connectedCallback(){
  if(this.allDataSet){
    this.error = this.allDataSet.componentLoaderror;
    if(this.error){
      this.showToast('Error', ''+this.error, 'error');
    }
    this.loadpagedata(this.allDataSet.fieldsRecordsdata);
    this.fieldsLable = this.allDataSet.fieldsLable;
    this.finalfieldsLable = this.allDataSet.fieldsLable;
    this.fieldsApiName = this.allDataSet.fieldsApiName;
    this.objectname = this.allDataSet.objectname;        
    this.tableHeadName = this.allDataSet.tableHeadName;
    this.recordsDatacount = this.allDataSet.recordsDatacount;
    this.ColumnSearchEnable = this.allDataSet.ColumnSearchEnable;
    this.paginationEnable = this.allDataSet.paginationEnable;
    this.ShortingEnable = this.allDataSet.ShortingEnable;
    this.SelectRowAction = this.allDataSet.SelectRowAction;
    this.GlobalSearchEnable = this.allDataSet.GlobalSearchEnable;
    this.ColumnShowHideMenu = this.allDataSet.ColumnShowHideMenu;
    this.GlobalFilterEnable = this.allDataSet.GlobalFilterEnable;
    this.fildNameWithType = this.allDataSet.fildNameWithType;
    this.recordsPerPage = this.allDataSet.recordsPerPage;
    this.searchableAllFields = this.allDataSet.searchableFields;
    this.componenttName = this.allDataSet.componenttName; 
    this.FieldsInlineEdit = this.allDataSet.FieldsInlineEdit;
    this.InlineEditEnable = this.allDataSet.InlineEditEnable;  
    let conts = this.allDataSet.columnManuSelect;
        for(let key in conts){
          this.columnManuSelect.push({value:conts[key], key:key,show:true, indexelm:this.fieldsApiName.indexOf(key)}); 
        } 
      this.handleFirst();            
  }
  
}
@api loadpagedata(editdataset){
  let allprocesdata = editdataset;
  this.fieldsRecordsdata=[]; 
  let recindexcnt =0;      
  for(let key in allprocesdata){ 
        if(this.selectedrecordids.length>0 && this.selectedrecordids.includes(''+allprocesdata[key].Id)){
          this.fieldsRecordsdata.push({recindex:recindexcnt,selectedrec : true,...allprocesdata[key]});
        }else{           
          this.fieldsRecordsdata.push({recindex:recindexcnt,selectedrec : false,...allprocesdata[key]}); 
        } 
        recindexcnt++;           
  }  
  this.AllData = this.fieldsRecordsdata;    
  this.Recordsdata = this.fieldsRecordsdata.slice(this.startindex,this.endIndex);
  let headersearchinput = this.template.querySelectorAll(`[data-inputval="headersearchval"]`);   
  headersearchinput.forEach(function(singlehtmlelemnt) { 
    singlehtmlelemnt.value='';
  });
  const resetElmntClass = this.template.querySelectorAll('.resetElmntClass');
    resetElmntClass.forEach(function(selectedItem) {
      selectedItem.setAttribute('class','slds-th__action slds-text-link--reset resetElmntClass NonSelectedBorderOrgType NonSelectedBorderOrgTypeDwn');
    });
  this.loading =false;
  
}

renderedCallback() {
  if(this.SelectRowAction){
  if(this.initialRender){
  const fltrRecordsdata = this.Recordsdata;
  let  selectedrecset =true;
  for(let key in fltrRecordsdata){
     if(!fltrRecordsdata[key].selectedrec){
      selectedrecset =false;
     }
  }
  const selectedelement = this.template.querySelector('[data-id="selectAllcheckedrecId"]');
  if(selectedrecset){
    selectedelement.checked=true;
  }else{
    selectedelement.checked=false;
  }  
  this.initialRender = false;
  }
}
}   
disconnectedCallback() {
}
filterHandler(){
  this.tableFilterMenu =true;
  this.showColumnMenu = false; 
}

tabledataupdate(event){
    const entAllvalues = event.detail;
    this.columnManuSelect = entAllvalues.Allcolm;
    if(!entAllvalues.clmshowhide){
      const filteredth = this.fieldsLable.filter(function(value, index, arr){
        return value.APiName !== entAllvalues.clmvaluename;  
      });
      const filteredtd = this.fieldsApiName.filter(function(value, index, arr){
        return value !== entAllvalues.clmvaluename;  
      });
      this.fieldsLable = filteredth;
      this.fieldsApiName = filteredtd;
    }else{
      const filteredth = this.finalfieldsLable.filter(function(value, index, arr){
        return value.APiName === entAllvalues.clmvaluename;  
      });
      this.fieldsLable.splice( entAllvalues.indexval, 0, filteredth[0]);
      this.fieldsApiName.splice( entAllvalues.indexval, 0, entAllvalues.clmvaluename);
    }
    this.showColumnMenu =false;        
    this.dispatchEvent(new CustomEvent(this.fieldsLable,this.fieldsApiName,this.showColumnMenu));    
}

handlesortColumn(event) { 
    try{
 
    if(this.editrecodid!==''){
      this.closeupdatepopupval =  true;
      this.paginationEnable = true;
      this.editmodelcomenmethod();
      //this.editrecodid ='';
    } 
    let columnIndex = event.target.getAttribute("data-value");
    const resetElmntClass = this.template.querySelectorAll('.resetElmntClass');
    resetElmntClass.forEach(function(selectedItem) {
      selectedItem.setAttribute('class','slds-th__action slds-text-link--reset resetElmntClass NonSelectedBorderOrgType NonSelectedBorderOrgTypeDwn');
    });
     
    let fieldName = this.fieldsApiName[columnIndex];
    if(this.sortfieldName !== fieldName){
      this.sortType = true;
      this.sortfieldName = fieldName;
    }  
    
    let jsonarray = this.fieldsRecordsdata; 
    this.sortBy(jsonarray,fieldName,this.sortType); 
      this.fieldsRecordsdata = jsonarray;
      
      this.handleFirst();
      if(this.sortType)
      this.sortType = false;
      else
      this.sortType = true;
      
      const evt = event.currentTarget;
      this.sortcurrenttarget = evt;
      if(!this.sortType){
      evt.classList.toggle('SelectedBorderOrgType');
      evt.classList.toggle('NonSelectedBorderOrgType');
      }else{        
      evt.classList.toggle('SelectedBorderOrgTypeDwn'); 
      evt.classList.toggle('NonSelectedBorderOrgTypeDwn');     
      }
      
      this.initialRender =true;
      //this.renderedCallback();
    }catch(error){
     
    }
}

sortBy(jsonarray,field,sortAsc) {
  jsonarray.sort(function(a,b){
      var t1 = a[field] === b[field],
          t2 = (!a[field] && b[field]) || (a[field] < b[field]);
      return t1? 0: (sortAsc?-1:1)*(t2?1:-1);
  }); 
}

columnMenuHandler(){     
  this.tableFilterMenu = false;
  this.showColumnMenu = true;
  //this.dispatchEvent(new CustomEvent(this.tableFilterMenu,this.showColumnMenu));
} 
handleKeyChangeForData(event){
  window.clearTimeout(this.delayTimeout);
  const searchKey = event.target.value;
  this.showselectedtype = 'selectallrecord';
  if(this.datasearchkey!==searchKey){
    getObjectsDetailList({ searchString : searchKey, componenttName: this.componenttName,startdate : '',enddate :''})
                      .then(result => {
                        this.allDataSet = result; 
                        this.columnManuSelect=[];
                        this.AllData=[];
                        this.fieldsRecordsdata=[];
                        this.connectedCallback();                        
                    })
                    .catch(error => {
                        this.error = error;
                    });   
  }
  this.datasearchkey = searchKey;
}

tabledatafilter(event){
  const entAllvalues = event.detail;
  if(this.startdate !== entAllvalues.startdate || this.enddate !== entAllvalues.enddate){
  getObjectsDetailList({ searchString : this.datasearchkey, componenttName: this.componenttName,startdate : entAllvalues.startdate,enddate : entAllvalues.enddate})
                      .then(result => {
                        this.allDataSet = result; 
                        this.columnManuSelect=[];                       
                        this.connectedCallback();
                    })
                    .catch(error => {
                        this.error = error;
                    });
    
    }
  this.startdate = entAllvalues.startdate;
  this.enddate = entAllvalues.enddate;
}
handleKeyChange(event) { 
    let strtype = !this.sortType;
    if (this.searchKey !== event.target.value) {
      this.searchKey = event.target.value;        
      let jsonarray = this.AllData;      
      let fieldName = this.fieldsApiName[event.target.name];      
      let srchkey = ''+event.target.value;
      let showselectedtype = this.showselectedtype;
     let resltdata = jsonarray.filter(function(value, index, arr){        
        let valueinstr ='';
        if(showselectedtype === 'selectedviewrecord' && value.selectedrec){
          valueinstr = ''+value[fieldName];
          return valueinstr.toLowerCase().includes(srchkey.toLowerCase());
        }else if(showselectedtype === 'selectallrecord'){
          valueinstr = ''+value[fieldName];
          return valueinstr.toLowerCase().includes(srchkey.toLowerCase());
        }          
      }); 
      this.fieldsRecordsdata = resltdata;
      if(this.sortfieldName!=null){
        this.sortBy(resltdata,this.sortfieldName,strtype);
      }
      this.recordsDatacount = resltdata.length;
      this.handleFirst();     
            
    }  
} 
handlerParentComp(event){ 
  try{ 
    this.tableFilterMenu =false;
    this.showColumnMenu = false;
    if(this.editrecodid!==''){
      this.closeupdatepopupval =  true;
      this.paginationEnable = true;
      this.editmodelcomenmethod();
     // this.editrecodid ='';
    } 
  }catch(error){
    
  }
}

editrecordfield(event){ 
  if(this.InlineEditEnable  && this.FieldsInlineEdit.includes(event.currentTarget.dataset.tdname)){ 
    if(this.editrecodid!==''){
    this.closeupdatepopupval =  true;
    this.editmodelcomenmethod();
    }  
    this.paginationEnable = false;
    this.editrecodid= event.currentTarget.dataset.recodid;
    this.edittdname = event.currentTarget.dataset.tdname;
    this.closeupdatepopupval =  false;
    this.editmodelcomenmethod();
  }
}
closeupdatepopup(event){
  this.paginationEnable = true;
  this.closeupdatepopupval =  true;
  this.editrecodid = event.detail.editrecodid;
  this.edittdname = event.detail.edittdname;
  this.editmodelcomenmethod();
  this.editrecodid ='';
  this.edittdname ='';
  this.closeupdatepopupval =  false;
  if(event.detail.eventtypebutton === 'Success'){
    this.loading = true;
    this.refreshcash = this.refreshcash + 1;
    this.dispatchEvent(new CustomEvent('refreshcomp',{ detail:{refreshcash: this.refreshcash}})); 
  }
}
editmodelcomenmethod(){
  try{
  let editrecodid = this.editrecodid;
  let edittdname = this.edittdname;
  let closeupdatepopupval = this.closeupdatepopupval;
  let recordrowdataeditcompid = this.template.querySelectorAll(`[data-id="${editrecodid}"]`); 
  let valuechecker = true;  
  recordrowdataeditcompid.forEach(function(singlehtmlelemnt) {     
    if(singlehtmlelemnt.dataset.name === edittdname && singlehtmlelemnt.dataset.class === 'editcompid'){ 
      if(closeupdatepopupval){
        singlehtmlelemnt.style = 'display: none;';
      }else{
        singlehtmlelemnt.style ='display: block;top:0;';
        valuechecker = false;
      }      
    }
    if(singlehtmlelemnt.dataset.name === edittdname && singlehtmlelemnt.dataset.class === 'outputvalueid'){ 
      if(closeupdatepopupval){
        singlehtmlelemnt.style ='display: block;';        
      }else{
        singlehtmlelemnt.style = 'display: none;';
      }       
    }
  });
  
  if(valuechecker){
    this.editrecodid =  '';
    this.edittdname = '';
  }
 }catch(error){
   
 }
}

handlerColumnSearch(event){  
  let state = false;
  let indxArray=[];
    let jsonarray = this.fieldsLable.forEach(function(oneItem) {
      indxArray.push(oneItem.Name);
    });

    const tdcontent = this.template.querySelectorAll('.tdcontent');
  tdcontent.forEach(function(selectedItem) {    
    let ind =  indxArray.indexOf(selectedItem.title);   
    if(event.target.name === ind)
    selectedItem.setAttribute('class','slds-truncate slds-hide tdcontent');
    else
    selectedItem.setAttribute('class','slds-truncate slds-show tdcontent');     
  });
    
    const selectedColumnFilter = this.template.querySelectorAll('.searchInput'); 
    selectedColumnFilter.forEach(function(selectedItem) {
      if(event.target.name === selectedItem.name){
      selectedItem.setAttribute('class','slds-truncate slds-show searchInput');
      state = true;
      }else{
      selectedItem.setAttribute('class','slds-truncate slds-hide searchInput'); 
      }    
  });  
  
}
//selection menu
handleRecords(event){  
  let datavaluename = event.target.getAttribute("data-name");  
  if(datavaluename === 'selectedviewrecord'){
  let alldataset = this.AllData;
  this.showselectedtype = 'selectedviewrecord';
  let fieldsRecordsdata=[];
  alldataset.forEach(function(selectedItem) {
    if(selectedItem.selectedrec){
      fieldsRecordsdata.push(selectedItem);
    }
  });
  this.fieldsRecordsdata =  fieldsRecordsdata;
 }else if(datavaluename === 'selectallrecord'){
  this.showselectedtype = 'selectallrecord';
  this.fieldsRecordsdata = this.AllData;   
 }
 this.recordsDatacount = this.fieldsRecordsdata.length;
 this.handleFirst();
}
 // select all record selection
handleChangeAllRec(event){  
  // Get the labels of selected checkboxes
  const filters = this.template.querySelectorAll('.recordselctbox');
  let state = true;
  let selectedrecordids = new Set(this.selectedrecordids);
  let indexArray =[];
  let alldat =this.AllData;
  let alldataset = this.fieldsRecordsdata;
  filters.forEach(function(selectedItem) { 
      indexArray.push(selectedItem.name);
      if(event.target.checked){
          selectedItem.checked = true; 
          state = true; 
      }else{
          selectedItem.checked = false;
          state = false;  
      }
    });
    alldataset.forEach(function(selectedItem) {
      if(indexArray.indexOf(selectedItem.recindex) > -1){
        if(state){
          selectedItem.selectedrec =true;
          alldat[selectedItem.recindex].selectedrec=true; 
          selectedrecordids.add(alldat[selectedItem.recindex].Id);
        }else{
          selectedItem.selectedrec =false;
          alldat[selectedItem.recindex].selectedrec=false;
          selectedrecordids.delete(alldat[selectedItem.recindex].Id); 
        }
      }
    });
    this.selectedrecordids = [...selectedrecordids];
    this.fieldsRecordsdata = alldataset;
    this.AllData =alldat;      
}
// single record selection Action
handleSelectedRec(event){
      let state = true; 
      let selectedrecordids = new Set(this.selectedrecordids);    
      let alldat =this.AllData; 
      let alldataset = this.fieldsRecordsdata;         
      const selectedelement = this.template.querySelector('[data-id="selectAllcheckedrecId"]');            
      if(event.target.checked){ 
          state = true;       
          const filters = this.template.querySelectorAll('.recordselctbox');
          let selsectedchk = true;                                          
              filters.forEach(function(selectedItem) {
                  if(!selectedItem.checked){
                      selsectedchk = false;                          
                  }
              })               
              if(selsectedchk){
                  selectedelement.checked = true;                   
              }else{
                  selectedelement.checked = false;                    
              }
      }else{     
          selectedelement.checked =false;
          state = false;                                          
      }
      alldataset.forEach(function(selectedItem) {
        if(selectedItem.recindex === event.target.name){
          if(state){
            selectedItem.selectedrec =true;
            alldat[selectedItem.recindex].selectedrec=true;
            selectedrecordids.add(alldat[selectedItem.recindex].Id); 
          }else{
            selectedItem.selectedrec =false;
            alldat[selectedItem.recindex].selectedrec=false;
            selectedrecordids.delete(alldat[selectedItem.recindex].Id); 
          }
        }
      });
      this.selectedrecordids = [...selectedrecordids];
      this.fieldsRecordsdata = alldataset; 
      this.AllData =alldat;       
      
}
//pagination logic
handleFirst(){
  if(this.paginationEnable){
  if(this.recordsPerPage < this.recordsDatacount){
    this.startindex = 0;            
    this.endIndex = this.recordsPerPage;
    this.Recordsdata = this.fieldsRecordsdata.slice(this.startindex,this.endIndex);                       
    this.showLastButton = false;
  }else{
    this.Recordsdata = this.fieldsRecordsdata.slice(0,this.recordsDatacount);
    this.showLastButton = true;
  } 
 }else{
  this.Recordsdata = this.fieldsRecordsdata;
 }
 this.totalPages = Math.ceil(this.recordsDatacount / this.recordsPerPage);    
 this.currentpage = 1;
 this.initialRender = true;
}
handlePrevious(){
  this.showLastButton = false;
  this.endIndex = this.startindex;
  this.startindex =this.startindex-this.recordsPerPage;    
  this.Recordsdata = this.fieldsRecordsdata.slice(this.startindex,this.endIndex);
  if (this.currentpage > 1) {  
    this.currentpage = this.currentpage - 1;  
  }
  this.initialRender =true;
}
handleNext(){
  if(this.endIndex < this.recordsDatacount){      
    this.startindex = this.endIndex;
    if(this.startindex + this.recordsPerPage < this.recordsDatacount)    
    this.endIndex = this.startindex + this.recordsPerPage;
    else
    this.endIndex = this.recordsDatacount; 
    this.Recordsdata = this.fieldsRecordsdata.slice(this.startindex,this.endIndex);         
  }else{
    this.startindex = this.startindex; 
    this.endIndex = this.recordsDatacount;
    this.Recordsdata = this.fieldsRecordsdata.slice(this.startindex,this.recordsDatacount);      
  }
      if (this.currentpage < this.totalPages)  
      this.currentpage = this.currentpage + 1;
      if (this.currentpage === this.totalPages) 
      this.showLastButton =true;  
      this.initialRender =true;
     
}
handleLast(){
  let modlores = this.recordsDatacount % this.recordsPerPage;
  if(modlores === 0){
    this.startindex = this.recordsDatacount-this.recordsPerPage; 
    this.endIndex = this.recordsDatacount;
  }else{
    this.startindex = this.recordsDatacount - modlores;  
    this.endIndex = this.recordsDatacount;
  }
  this.Recordsdata = this.fieldsRecordsdata.slice(this.startindex,this.endIndex);
  this.showLastButton =true;
  this.currentpage = this.totalPages;
  this.initialRender =true;
}
//pagination logic end 

  
}