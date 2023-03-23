public with sharing class firstApex {
    @AuraEnabled
    public static String getValue(String recordId){
        return 'Updated record ' + recordId;
    }
}