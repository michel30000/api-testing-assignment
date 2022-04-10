from locust import HttpUser, task, constant
from random import randrange, randint

class MovieDbUser(HttpUser):
    api_params = {'api_key': 'yourapikeyhere'}
    wait_time = constant(1)

    host = 'https://api.themoviedb.org/3'

    @task
    def get_ratings(self):
        self.client.get(f'/movie/top_rated', params=self.api_params)
    
    @task
    def rate_and_delete(self):
        movie_id = self.random_movie_id()
        my_rating = randint(1, 10)
        self.client.post(f'/movie/{movie_id}/rating', params=self.api_params, json={'value': my_rating})
        self.client.delete(f'/movie/{movie_id}/rating', params=self.api_params)

    def on_start(self):
        self.create_guest_session()

    def random_movie_id(self):
        return randrange(9999)
    
    def create_guest_session(self):
        resp = self.client.get('/authentication/guest_session/new', params=self.api_params)
        self.api_params['guest_session_id'] = resp.json()['guest_session_id']
