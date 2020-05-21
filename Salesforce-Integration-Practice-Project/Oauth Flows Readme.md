# SALESFORCE OAUTH FLOW

### Different OAuth Flows
      1) UserName - Password Flow
      2) User Agent Flow
      3) Web Server Flow
      4) JWT Bearer Token Flow
      5) Device Flow for IoT
      6) Asset Token Flow
      7) Refresh Token Flow
      8) SAML Bearer Assertion Flow

### UserName - Password Flow

#### `End Point`  
      https://login.salesforce.com/services/oauth2/token

#### `Parameters`
      1) grant_type = password
      2) client_id = consumerKey
      3) client_secret = consumersecret
      4) username= salesforce username
      5) password= password + security token

#### `Responce`
```Json
{
      "access_token":"SESSION_ID_REMOVED",
      "instance_url":"https://am13aa-dev-ed.my.salesforce.com",
      "id":"https://login.salesforce.com/id/00D4P000000gfFOUAY/0054P0000096lbiQAA",
      "token_type":"Bearer",
      "issued_at":"1561478340074",
      "signature":"xLNXG6mYSY/nw9etYpRDS/broumG+/EgpZOUadZ1/aQ="
    
}
```


        
