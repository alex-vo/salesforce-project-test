trigger MyCustomLeadTrigger on Lead (before update) {
   List<Lead> newLeads = Trigger.New;
   Map<Id, Lead> oldMap = Trigger.oldMap;
   for(Lead lead: newLeads) {
       if(lead.Status == 'Working - Contacted' && oldMap != null && oldMap.get(lead.Id) != null && oldMap.get(lead.Id).Status == 'Open - Not Contacted') {
           /*System.debug('====================');
           System.debug('desired status transition');
           System.debug('====================');*/
           lead.Website = 'BerthaBoxer.com';
       } else {
           System.debug('====================');
           System.debug('other status transition');
           System.debug('====================');
           lead.Website = 'BerthaBoxer1.com';
       }
   }
}