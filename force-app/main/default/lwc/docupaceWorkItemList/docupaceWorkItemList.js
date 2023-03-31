import { LightningElement } from 'lwc';
import fetchWorkItems from '@salesforce/apex/DocupaceWorkItemFetcher.fetchWorkItems';

export default class DocupaceWorkItemList extends LightningElement {

    workItemList;

    columns = [
        {
          label: 'Id',
          fieldName: 'workItemId'
        },
        {
          label: 'SLA Start Time',
          fieldName: 'slaStartTime'
        },
        {
          label: 'SLA Stop Time',
          fieldName: 'slaStopTime'
        },
        {
          label: 'Error Description',
          fieldName: 'errorDescription'
        },
        {
          label: 'Created',
          fieldName: 'createdTimestamp'
        },
        {
          label: 'Assigned User',
          fieldName: 'assignedUser'
        },
        {
          label: 'Task Name',
          fieldName: 'taskName'
        },
        {
          label: 'Request Type Name',
          fieldName: 'requestTypeName'
        },
        {
          label: 'Request Status Name',
          fieldName: 'requestStatusName'
        },
        {
          label: 'Account Number',
          fieldName: 'accountNumber'
        },
        {
          label: 'Clients',
          fieldName: 'clients'
        }
        //todo reps
    ];

    connectedCallback() {
        fetchWorkItems({startPos: 0, pageSize: 10})
          .then(response => {
            console.log(response.workItemList);
            this.workItemList = response.workItemList
              .map((workItem) => {
                const wi = {
                  workItemId: workItem.workItemId,
                  slaStartTime: workItem.slaStartTime,
                  slaStopTime: workItem.slaStopTime,
                  errorDescription: workItem.errorDescription,
                  createdTimestamp: workItem.createdTimestamp,
                  assignedUser: workItem.assignedUser,
                  taskName: workItem.taskName,
                  requestTypeName: workItem.requestTypeName,
                  requestStatusName: workItem.requestStatusName,
                  accountNumber: workItem.account.accountNumber,
                  clients: workItem.account.clients
                    .map((client) => `${client.fullName} Abc2`)
                    .join('\n'),
                };
                return wi;
              });
          });
    }

}