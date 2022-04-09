FROM python:3.10
ENV API_KEY=
COPY . /robot
COPY ./Test /robot
WORKDIR /robot
RUN pip install -r requirements.txt
CMD robot -v moviedb_api_key:$API_KEY --outputdir /robot/results/ ./Test