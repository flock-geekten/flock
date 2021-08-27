from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

import extractive_summarization as es

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,   # 追記により追加
    allow_methods=["*"],      # 追記により追加
    allow_headers=["*"]       # 追記により追加
)

@app.get("/")
def read_root():
    return {"Hey! I'm rrrrind!"}

@app.get("/{sum_count}/{text}")
def read_item(sum_count: int, text: str):
    return es.preprocessed_lexrank(text, sum_count=sum_count)
