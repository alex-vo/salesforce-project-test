import LightningDatatable from 'lightning/datatable';
import clientsType from './clientsType';
import repsType from './repsType';

export default class DocupaceLightningDatatable extends LightningDatatable {
  static customTypes = {
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