import { LightningElement, api } from 'lwc';
import getValue from '@salesforce/apex/firstApex.getValue';

export default class FirstExampleComponent extends LightningElement {

  @api recordId;

  responzz;

  hello(){
    console.log('recordId ' + this.recordId);

    getValue({recordId: `${this.recordId}`})
      .then(response => {
        this.responzz = response;
      });
  }
}