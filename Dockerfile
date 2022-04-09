FROM python:3.10
COPY . /robot
COPY ./Test /robot
WORKDIR /robot
RUN pip install -r requirements.txt
CMD ["robot", "--outputdir", "/robot/results/", "./Test"]