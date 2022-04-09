*** Settings ***
Library  RequestsLibrary
Library  Collections
Test setup  set initial api paramaters

*** Variables ***
${moviedb_api_key}
${moviedb_endpoint}  https://api.themoviedb.org/3

*** Test Cases ***
correct request for top rated movies
    When the moviedb api receives a GET request on path /movie/top_rated
    Then the api response code must be 200

unauthorized request for top rated movies
    Given the moviedb api key used is <hunter2>
    When the moviedb api receives a GET request on path /movie/top_rated
    Then the api response code must be 401

incorrect http method on top rated movies
    When the moviedb api receives a DELETE request on path /movie/top_rated
    Then the api response code must be 405

correct request for rating a movie
    [Teardown]  delete rating for movie 278
    Given a moviedb guest session is created
    When the moviedb api receives a POST request on path /movie/278/rating with json body <{"value": 8.5}>
    Then the api response code must be 201

unauthorized request for rating a movie
    Given a moviedb guest session is created
    And the moviedb api key used is <hunter2>
    When the moviedb api receives a POST request on path /movie/278/rating with json body <{"value": 8.5}>
    Then the api response code must be 401

rating a movie without a guest session
    When the moviedb api receives a POST request on path /movie/278/rating with json body <{"value": 8.5}>
    Then the api response code must be 401

*** Keywords ***
### Given keywords 
the moviedb api key used is <${api_key}>
    Set To Dictionary  ${api_params}  api_key=${api_key}

the moviedb guest session id used is <${guest_Session_id}>
    Set To Dictionary  ${api_params}  guest_session_id=${guest_Session_id}

a moviedb guest session is created
    ${response}=  GET  ${moviedb_endpoint}/authentication/guest_session/new  params=${api_params}
    Set To Dictionary  ${api_params}  guest_session_id=${response.json()}[guest_session_id]

### When keywords
the moviedb api receives a ${req_type:GET|DELETE} request on path ${path:/.*}
    ${api_response}=  Run keyword  ${req_type}  ${moviedb_endpoint}${path}  params=${api_params}  expected_status=anything
    Set test variable  ${api_response}
    Run keyword and continue on failure  Log  ${api_response.json()}

the moviedb api receives a POST request on path ${path:/.*} with json body <${body_json}>
    ${body_json}=  Evaluate  json.loads($body_json)  modules=json
    ${api_response}=  POST  ${moviedb_endpoint}${path}  json=${body_json}  params=${api_params}  expected_status=anything
    Set test variable  ${api_response}
    Run keyword and continue on failure  Log  ${api_response.json()}

### Then keywords
the api response code must be ${expected_response_code}
    Status should be  ${expected_response_code}

### Support keywords
set initial api paramaters
    ${api_params}=  Create dictionary  api_key=${moviedb_api_key}
    Set test variable  ${api_params}

delete rating for movie ${movie_id}
    DELETE  ${moviedb_endpoint}/movie/${movie_id}/rating  params=${api_params}
