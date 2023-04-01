import { LightningElement, api } from 'lwc';

export default class WorkItemIdType extends LightningElement {
   @api workItemId;

   @api
   get url() {
       return `/lightning/n/Work_Item_Details#${this.workItemId}`;
   }

}