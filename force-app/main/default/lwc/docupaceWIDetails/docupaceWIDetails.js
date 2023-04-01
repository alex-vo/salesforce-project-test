import { LightningElement } from 'lwc';

export default class DocupaceWIDetails extends LightningElement {

  workItemId = '';

  connectedCallback() {
    const str = window.location.hash.substring(1);
    console.log(str);
    this.workItemId = window.location.hash.substring(1)
  }
}