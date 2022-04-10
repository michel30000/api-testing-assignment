# api-testing-assignment
## Running the tests
This test suite for The movie db is built in Robot framework. Thus, you will need python to run it. I recommend the latest version of python but any version >=3.7 will do.

After pulling the repository run `pip install -r requirements.txt` to install the python requirements for running the Robot suite and the load test.

If robot framework installed correctly you are ready to run the test suite using `robot -v moviedb_api_key:<your_api_key_here> ./Test` (put your api key without the < and > characters!). If for some reason the robot binary was not added to your search path run `python -m robot -v moviedb_api_key:<your_api_key_here> ./Test` instead.

### Test log file
After a test run you'll find the Robot Framework test execution report (report.html) and test log (log.html) in the root of this repository.

## Running the tests in Docker
Build the container using
`docker build -t api-testing-assignment .`

Run the container with `docker run -e "API_KEY=<your_api_key_here>" api-testing-assignment`. Again, supply your api key without the < and > characters!

You can optionally use the -v flag to map the test result directory `/robot/results/` to a local directory eg.:
`docker run -e "API_KEY=<your_api_key_here>" -v /Users/Michel/Documents/api-testing-assignment/docker_results:/robot/results api-testing-assignment`

## Load test
This repository includes a load test implemented in the Locust load testing framework (https://locust.io). To run this load testing suite for themoviedb edit the file LoadTest/locustfile.py, update the line `api_params = {'api_key': 'yourapikeyhere'}` with your api key. Then simply go to the LoadTest directory and run `locust`. Then point a browser to http://0.0.0.0:8089 to open the Locust web ui. You will be asked to enter an amount of locust users. Now, each user will request the top rated movies, and post and delete a rating for a random movie, each at a rate of 1 request per second. So the more users you use, the higher the api load. You may also pick a user spawn rate. For more info on locust go here http://docs.locust.io/en/stable/