*** Settings ***
Library  RequestsLibrary

*** Variables ***
${your_movie_db_api_key_v3}  a9745c01ee1fbad5f4c587c4b179e230
${your_movie_db_api_key_v4}  eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOTc0NWMwMWVlMWZiYWQ1ZjRjNTg3YzRiMTc5ZTIzMCIsInN1YiI6IjYyNTFjM2I0MDkxOTFiMDA2NTc0ZTY5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FItZu3GC0-tVNczAhZWsQ5VwSCXKeikKCbcBisiuGfw

${moviedb_endpoint}  https://api.themoviedb.org/3
${api_params}  api_key=${your_movie_db_api_key_v3}


*** Test Cases ***
correct request for top rated movies
    When the moviedb api receives a GET request on path /movie/top_rated
    Then the api response code must be 200

unauthorized request for top rated movies
    Given the moviedb api key used is <hunter2>
    When the moviedb api receives a GET request on path /movie/top_rated
    Then the api response code must be 401

incorrect http method on top rated movies
    When the moviedb api receives a POST request on path /movie/top_rated
    Then the api response code must be 405

correct request for rating a movie
    When the moviedb api receives a GET request on path /rate-movie

*** Keywords ***
the moviedb api receives a GET request on path ${path:/.*}
    ${api_response}=  GET  ${moviedb_endpoint}${path}  params=${api_params}  expected_status=anything
    Set test variable  ${api_response}
    Run keyword and continue on failure  Log  ${api_response.json()}

the moviedb api receives a ${req_type:PUT|POST} request on path ${path:/.*}
    
the api response code must be ${expected_response_code}
    Status should be  ${expected_response_code}

the moviedb api key used is <${api_key}>
    ${api_params}=  Create Dictionary  api_key=${api_key}
    Set test variable  ${api_params}