public with sharing class DocupaceDTOs {

    public class WorkItemPage {
      @AuraEnabled
      public List<WorkItemDTO> workItemList;
    }

    public class WorkItemDTO {
        @AuraEnabled
        public String workItemId;
        @AuraEnabled
        public String slaStartTime;
        @AuraEnabled
        public String slaStopTime;
        @AuraEnabled
        public String errorDescription;
        @AuraEnabled
        public String createdTimestamp;
        @AuraEnabled
        public String assignedUser;
        @AuraEnabled
        public String taskName;
        @AuraEnabled
        public String requestTypeName;
        @AuraEnabled
        public String requestStatusName;
        @AuraEnabled
        public AccountDTO account;
    }

    public class AccountDTO {
        @AuraEnabled
        public String accountNumber;
        @AuraEnabled
        public List<ClientDTO> clients;
        @AuraEnabled
        public List<RepDTO> reps;
    }

    public class RepDTO {
        @AuraEnabled
        public String repNumber;
    }

    public class ClientDTO {
        @AuraEnabled
        public String fullName;
        @AuraEnabled
        public String tinSsn;
    }

    public class DocupaceResponse {
        public Integer startPosition;
        public Boolean moreRecords;
        public List<Domain> records;
    }

    public class Domain {
        public Integer domainId;
        public Integer id;
        public List<AttrValue> attrValues;
    }

    public class AttrValue {
        public String type;
        public Integer attrId;
        public String value;
        public String valueType;
        public List<AttrValue> attrValues;
        public Integer domainId;

        public String getAttrValue() {
            return getAttrValueById(100001);
        }

        public String getAttrValueById(Integer attrId) {
            String value = '';
            if (this.attrValues == null && this.attrId == attrId){
                value = this.value;
            } else {
                for (AttrValue attr : attrValues) {
                    System.debug('ATTR.ATTR_ID: ' + attr.attrId);
                    if (attr.attrId == attrId) {
                        System.debug('ATTR.TYPE: ' + attr.type);
                        if (attr.type.equals('list')) {
                            System.debug('ATTR.ATTRVALUES: ' + attr.type);
                            if (attr.attrValues != null && !attr.attrValues.isEmpty()) {
                                value = attr.attrValues.get(attr.attrValues.size() - 1).getAttrValue();
                            }
                        } else {
                            value = attr.value;
                        }
                        break;
                    }
                }
            }
            System.debug('ATTR ID: ' + attrId + '; VALUE: ' + value);
            return value;
        }
    }
}