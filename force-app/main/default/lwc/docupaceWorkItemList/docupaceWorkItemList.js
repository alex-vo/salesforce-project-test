import { LightningElement } from 'lwc';
import fetchWorkItems from '@salesforce/apex/DocupaceWorkItemFetcher.fetchWorkItems';

export default class DocupaceWorkItemList extends LightningElement {

    workItemList;

    columns = [
        {
          label: 'Id',
          fieldName: 'workItemId',
          type: 'workItemIdType',
          wrapText: true,
          typeAttributes: {
            workItemId: { fieldName: 'workItemId' },
          }
        },
        {
          label: 'Clients',
          fieldName: 'clients',
          type: 'clientsType',
          wrapText: true,
          typeAttributes: {
            clients: { fieldName: 'clients' },
          }
        },
        {
          label: 'SLA Start Time',
          fieldName: 'slaStartTime',
          wrapText: true
        },
        {
          label: 'SLA Stop Time',
          fieldName: 'slaStopTime',
          wrapText: true
        },
        {
          label: 'Error Description',
          fieldName: 'errorDescription',
          wrapText: true
        },
        {
          label: 'Created',
          fieldName: 'createdTimestamp',
          wrapText: true
        },
        {
          label: 'Assigned User',
          fieldName: 'assignedUser',
          wrapText: true
        },
        {
          label: 'Task Name',
          fieldName: 'taskName',
          wrapText: true
        },
        {
          label: 'Request Type Name',
          fieldName: 'requestTypeName',
          wrapText: true
        },
        {
          label: 'Request Status Name',
          fieldName: 'requestStatusName',
          wrapText: true
        },
        {
          label: 'Account Number',
          fieldName: 'accountNumber',
          wrapText: true
        },
        {
          label: 'Reps',
          fieldName: 'reps',
          type: 'repsType',
          wrapText: true,
          typeAttributes: {
            reps: { fieldName: 'reps' },
          }
        }
    ];

    connectedCallback() {
        fetchWorkItems({startPos: 0, pageSize: 10})
          .then(response => {
            console.log(response.workItemList);
            this.workItemList = response.workItemList
              .map((workItem) => {
                const wi = {
                  workItemUrl: '/lightning/n/Work_Items#111',
                  workItemId: workItem.workItemId,
                  slaStartTime: workItem.slaStartTime ? new Date(workItem.slaStartTime).toLocaleString() : workItem.slaStartTime,
                  slaStopTime: workItem.slaStopTime ? new Date(workItem.slaStopTime).toLocaleString() : workItem.slaStopTime,
                  errorDescription: workItem.errorDescription,
                  createdTimestamp: workItem.createdTimestamp ? new Date(workItem.createdTimestamp).toLocaleString() : workItem.createdTimestamp,
                  assignedUser: workItem.assignedUser,
                  taskName: workItem.taskName,
                  requestTypeName: workItem.requestTypeName,
                  requestStatusName: workItem.requestStatusName,
                  accountNumber: workItem.account.accountNumber,
                  clients: workItem.account.clients,
                  reps: workItem.account.reps,
                };
                return wi;
              });
          });
    }

}