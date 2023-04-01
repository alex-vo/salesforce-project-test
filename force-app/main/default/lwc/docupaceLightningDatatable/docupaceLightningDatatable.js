import LightningDatatable from 'lightning/datatable';
import clientsType from './clientsType';
import repsType from './repsType';
import workItemIdType from './workItemIdType';

export default class DocupaceLightningDatatable extends LightningDatatable {
  static customTypes = {
      workItemIdType: {
          template: workItemIdType,
          typeAttributes: ['workItemId']
      },
      clientsType: {
          template: clientsType,
          typeAttributes: ['clients']
      },
      repsType: {
          template: repsType,
          typeAttributes: ['reps']
      }
  }
}