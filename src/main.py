from fastapi import FastAPI
from src.env import config

MODE = config("MODE", default="dev", cast=str)

app = FastAPI()

@app.get("/")
def home_page():
    return {"message": "Hello, World!", "mode": MODE}
