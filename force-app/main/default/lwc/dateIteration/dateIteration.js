import { LightningElement, track } from 'lwc';

export default class DateIteration extends LightningElement {
    @track days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    @track storeDate = [];
    //  @track storeDay = [];


    connectedCallback() {
        var currentDate = new Date();
        this.onlyDate = currentDate.getDate();
        this.onlyMonth = currentDate.getMonth() + 1;
        this.crctMonth = currentDate.getMonth();

        this.onlyYear = currentDate.getFullYear();
        this.onlyDay = currentDate.getDay();
        this.curentdays = this.days[this.onlyDay];
        var lastDate = new Date(this.onlyYear, this.onlyMonth, 0);
        this.last = lastDate.getDate();
        var firstDate = new Date(this.onlyYear, this.crctMonth, 1);
        this.firstday = firstDate.getDay();
        console.log("first" + this.first);

        for (let i = 1; i <= this.last; i++) {
            let str = this.numberPadding(i) + "-" + this.numberPadding(this.onlyMonth) + "-" + this.onlyYear;

            let day = this.days[this.firstday];
            let dateday = { strday: day, strdate: str };
            this.storeDate.push(dateday);
            console.log("storeDate" + this.storeDate);
            this.firstday++;
            if (this.firstday > 6) {
                this.firstday = 0;
            }

        }


    }
    numberPadding(n) {
            return String(n).padStart(2, '0');
        }
        /*  for (let i = this.onlyDay; i <= 6; i++) {
              let day = this.days[i];
              this.storeDay.push(day);
              if (this.i = 6) {
                  // this.i = 0;
              }*/
}