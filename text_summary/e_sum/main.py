from fastapi import FastAPI

import extractive_summarization as es

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hey! I'm rrrrind!"}

@app.get("/{sum_count}/{text}")
def read_item(sum_count: int, text: str):
    return es.preprocessed_lexrank(text, sum_count=sum_count)
