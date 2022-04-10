from locust import HttpUser, task, constant

class MovieDbUser(HttpUser):
    api_params = {"api_key": "yourapikeyhere"}
    wait_time = constant(1)

    @task
    def get_ratings(self):
        self.client.get("/movie/top_rated", params=self.api_params)
    
    @task
    def rate_and_delete(self):
        pass