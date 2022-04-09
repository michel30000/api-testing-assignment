# api-testing-assignment
## Running the tests
This test suite for The movie db is built in Robot framework. Thus, you will need python to run it. I recommend the latest version of python but any version >=3.7 will do.

After pulling the repository run `pip install -r requirements.txt` to install the python requirements for running the suite.

If robot framework installed correctly you are ready to run the test suite using `robot ./Test`. If for some reason the robot binary was not added to your search path run `python -m robot ./Test` instead.

## Running the tests in Docker
Build the container using
`docker build -t api-testing-assignment .`

Run the container with `docker run  api-testing-assignment`

You can optionally use the -v flag to map the test result directory `/robot/results/` to a local directory eg.:
`docker run -v /Users/Michel/Documents/api-testing-assignment/docker_results:/robot/results api-testing-assignment`