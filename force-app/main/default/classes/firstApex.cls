public with sharing class firstApex {
    @AuraEnabled
    public static String getValue(String recordId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String username = 'aleksei_vorontsov';
        String password = 'Alex8899747!';

        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' +
        EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);
        request.setEndpoint('https://www.preprod.docupaceinc.com/oa_b2b/rest/v1/security/who-am-i');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            return response.getBody();
        }
        return 'got error response ' + response.getStatusCode() + ' ' + response.getBody();
    }
}