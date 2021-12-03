import { LightningElement, track } from 'lwc';

export default class Calculator extends LightningElement {
    @track result;
    @track fVal = '';
    @track sVal;
    @track one;
    @track two;

    @track result;
    handleFval(event) {
            this.fVal = event.target.value;
            console.log(this.fVal);
        }
        /*handleSval(event) {
            this.sVal += event.target.value;
            console.log(this.sVal);

        }*/
    handleClear() {
        this.fVal = '';
    }
    handleResult() {
        this.fVal = eval(this.fVal);
        console.log(this.two);
    }
    handleOne(event) {
            if (event.target.name === 'one') {
                this.fVal += '1';
            } else if (event.target.name === 'two') {
                this.fVal += '2';
            } else if (event.target.name === 'three') {
                this.fVal += '3';
            } else if (event.target.name === '/') {
                this.fVal += '/';
            } else if (event.target.name === 'four') {
                this.fVal += '4';
            } else if (event.target.name === 'five') {
                this.fVal += '5';
            } else if (event.target.name === 'six') {
                this.fVal += '6';
            } else if (event.target.name === '-') {
                this.fVal += '-';
            } else if (event.target.name === 'seven') {
                this.fVal += '7';
            } else if (event.target.name === 'eight') {
                this.fVal += '8';
            } else if (event.target.name === 'nine') {
                this.fVal += '9';
            } else if (event.target.name === '+') {
                this.fVal += '+';
            } else if (event.target.name === '.') {
                this.fVal += '.';
            } else if (event.target.name === '0') {
                this.fVal += '0';
            } else if (event.target.name === '*') {
                this.fVal += '*';
            }
        }
        /*  addition() {
              let test = parseInt(this.fVal) + parseInt(this.sVal);
              this.result = eval(test);
              console.log(this.result);
          }
          subtraction() {
              this.result = this.fVal - this.sVal;
              console.log(this.result);
          }
          multiplication() {
              this.result = this.fVal * this.sVal;
              console.log(this.result);
          }
          division() {
              this.result = this.fVal / this.sVal;
              console.log(this.result);
          }
          modulo() {
              this.result = this.fVal % this.sVal;
              console.log(this.result);

          }
          clearScreen() {

          }*/
}