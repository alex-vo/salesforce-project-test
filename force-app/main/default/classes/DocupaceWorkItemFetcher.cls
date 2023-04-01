public with sharing class DocupaceWorkItemFetcher {

    @AuraEnabled
    public static DocupaceDTOs.WorkItemPage fetchWorkItems(Integer startPos, Integer pageSize) {
      DocupaceDTOs.DocupaceResponse docuResponse = getWorkItems(startPos, pageSize);
      DocupaceDTOs.WorkItemPage page = new DocupaceDTOs.WorkItemPage();
      if (docuResponse.records.isEmpty()) {
        return page;
      }

      page.workItemList = new List<DocupaceDTOs.WorkItemDTO>();
      for (DocupaceDTOs.Domain record : docuResponse.records) {
        DocupaceDTOs.WorkItemDTO workItemDTO = new DocupaceDTOs.WorkItemDTO();
        processAttributeValues(workItemDTO, record);

        page.workItemList.add(workItemDTO);
      }

      return page;
    }

    static String getAttributeStringValue(DocupaceDTOs.AttrValue attrValue) {
       return attrValue.value;
    }

    static void processAttributeValues(DocupaceDTOs.WorkItemDTO workItemDTO, DocupaceDTOs.Domain record){
      for(DocupaceDTOs.AttrValue attrValue: record.attrValues) {
        if(attrValue.attrId == 105099) {
          workItemDTO.workItemId = attrValue.value;
        } else if (attrValue.attrId == 120008) {
          workItemDTO.slaStartTime = attrValue.value;
        } else if (attrValue.attrId == 120009) {
          workItemDTO.slaStopTime = attrValue.value;
        } else if (attrValue.attrId == 101508) {
          workItemDTO.errorDescription = attrValue.value;
        } else if (attrValue.attrId == 120002) {
          workItemDTO.createdTimestamp = attrValue.value;
        } else if (attrValue.attrId == 100288) {
          workItemDTO.assignedUser = attrValue.value;
        } else if (attrValue.attrId == 27601 && attrValue.domainId == 276) {
          processTaskName(workItemDTO, attrValue);
        } else if (attrValue.attrId == 42001 && attrValue.domainId == 420) {
          processRequestType(workItemDTO, attrValue);
        } else if (attrValue.attrId == 42201 && attrValue.domainId == 422) {
          processRequestStatus(workItemDTO, attrValue);
        } else if (attrValue.attrId == 10006 && attrValue.domainId == 115) {
          workItemDTO.account = new DocupaceDTOs.AccountDTO();
          workItemDTO.account.clients = new List<DocupaceDTOs.ClientDTO>();
          workItemDTO.account.reps = new List<DocupaceDTOs.RepDTO>();
          processClientAccount(workItemDTO.account, attrValue);
        }
      }
    }

    static void processTaskName(DocupaceDTOs.WorkItemDTO workItemDTO, DocupaceDTOs.AttrValue attributeValue) {
      for(DocupaceDTOs.AttrValue attrValue: attributeValue.attrValues) {
        if (attrValue.attrId == 100296) {
          workItemDTO.taskName = attrValue.value;
        }
      }
    }

    static void processRequestType(DocupaceDTOs.WorkItemDTO workItemDTO, DocupaceDTOs.AttrValue attributeValue) {
      for(DocupaceDTOs.AttrValue attrValue: attributeValue.attrValues) {
        if (attrValue.attrId == 100001) {
          workItemDTO.requestTypeName = attrValue.value;
        }
      }
    }

    static void processRequestStatus(DocupaceDTOs.WorkItemDTO workItemDTO, DocupaceDTOs.AttrValue attributeValue) {
      for(DocupaceDTOs.AttrValue attrValue: attributeValue.attrValues) {
        if (attrValue.attrId == 100001) {
          workItemDTO.requestStatusName = attrValue.value;
        }
      }
    }

    static void processClientAccount(DocupaceDTOs.AccountDTO accountDTO, DocupaceDTOs.AttrValue attributeValue) {
      for(DocupaceDTOs.AttrValue attrValue: attributeValue.attrValues) {
        if (attrValue.attrId == 100007) {
          accountDTO.accountNumber = attrValue.value;
        } else if (attrValue.attrId == 10002) {
          DocupaceDTOs.ClientDTO clientDTO = new DocupaceDTOs.ClientDTO();
          processClient(clientDTO, attrValue);
          accountDTO.clients.add(clientDTO);
        } else if (attrValue.attrId == 11801) {
          DocupaceDTOs.RepDTO repDTO = new DocupaceDTOs.RepDTO();
          processRep(repDTO, attrValue);
          accountDTO.reps.add(repDTO);
        }
      }
    }

    static void processClient(DocupaceDTOs.ClientDTO clientDTO, DocupaceDTOs.AttrValue attributeValue) {
      for(DocupaceDTOs.AttrValue attrValue: attributeValue.attrValues) {
        if (attrValue.attrId == 101515) {
          clientDTO.fullName = attrValue.value;
        } else if (attrValue.attrId == 100301) {
          clientDTO.tinSsn = attrValue.value;
        }
      }
    }

    static void processRep(DocupaceDTOs.RepDTO repDTO, DocupaceDTOs.AttrValue attributeValue) {
      for(DocupaceDTOs.AttrValue attrValue: attributeValue.attrValues) {
        if (attrValue.attrId == 100008) {
          repDTO.repNumber = attrValue.value;
        }
      }
    }

    static DocupaceDTOs.DocupaceResponse getWorkItems(Integer startPos, Integer pageSize) {
      String endpoint = 'https://www.dev.docupaceinc.com/team1_b2b/rest/v1/domains/401/records/data.json?startPos='
        + startPos + '&maxRows=' + pageSize
        + '&attrSet=105099,120008,120009,101508,120002,100288,27601:276-100296,42001:420-100001,42201:422-100001,10006:115-100007,10006:115-10002,10006:115-10002-101515,10006:115-10002-100301,10006:115-11801-100008';

      String jsonResponse = getResponse(endPoint, true);

      DocupaceDTOs.DocupaceResponse docuResponse = (DocupaceDTOs.DocupaceResponse) System.JSON.deserialize(
        jsonResponse,
        DocupaceDTOs.DocupaceResponse.class
      );

      return docuResponse;
    }

    private static String getResponse(String urlRest, Boolean isDecode) {
        String jsonResponse = '';
        System.debug('URL REST: ' + urlRest);
        HttpResponse response;
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        String username = 'aleksejs_voroncovs';
        String password = 'Qwerty!21';
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' +
        EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);
        request.setTimeout(60000);
        request.setEndPoint(urlRest);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'text/json');
        request.setHeader('Accept', 'application/json');
        response = handleResponseLocation(httpProtocol.send(request), isDecode);
        jsonResponse = response.getBody();

        System.debug('DOCUPACE RESPONSE: ' + jsonResponse);
        return jsonResponse.replaceAll('@type', 'type').replaceAll('@valueType', 'valueType');

    }

    private static HttpResponse handleResponseLocation(HttpResponse response, Boolean isDecode) {
       Http httpProtocol = new Http();
       if (response.getStatusCode() == 302 || response.getStatusCode() == 307 || response.getStatusCode() == 308) {
           String urlLocation = response.getHeader('Location');
           urlLocation = isDecode ? EncodingUtil.urlDecode(urlLocation, 'UTF-8') : urlLocation;
           System.debug('RESPONSE HEADER KEYS: ' + response.getHeaderKeys());
           System.debug('RESPONSE LOCATION URL: ' + urlLocation);
           System.debug('RESPONSE DECODE LOCATION URL: ' + isDecode);
           System.debug('RESPONSE COOKIE: ' + response.getHeader('Set-Cookie'));
           HttpRequest requestLocation = new HttpRequest();
           requestLocation.setTimeout(60000);
           requestLocation.setEndPoint(urlLocation);
           requestLocation.setMethod('GET');
           requestLocation.setHeader('Cookie', response.getHeader('Set-Cookie'));
           requestLocation.setHeader('Content-Type', 'text/json');
           requestLocation.setHeader('Accept', 'application/json');
           response = httpProtocol.send(requestLocation);
       }
       if (response.getStatusCode() == 302 || response.getStatusCode() == 307 || response.getStatusCode() == 308) {
           response = handleResponseLocation(response, isDecode);
       } else if (response.getStatusCode() != 200) {
           System.debug('BAD RESPONSE: ' + response);
           System.debug('BAD RESPONSE LOCATION : ' + response.getHeader('Location'));
           System.debug('BAD RESPONSE COOKIE: ' + response.getHeader('Set-Cookie'));
       }

       return response;
   }

}