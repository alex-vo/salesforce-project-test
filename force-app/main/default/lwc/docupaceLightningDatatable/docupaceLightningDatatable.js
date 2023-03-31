import LightningDatatable from 'lightning/datatable';
import clientType from './clientType';

export default class DocupaceLightningDatatable extends LightningDatatable {
  static customTypes = {
      customTypeA: {
          template: clientType,
          typeAttributes: ['clients']
      }
  }
}