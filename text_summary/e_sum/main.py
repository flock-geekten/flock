from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

import extractive_summarization as es

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,   # 追記により追加
    allow_methods=["*"],      # 追記により追加
    allow_headers=["*"]       # 追記により追加
)

class Summary(BaseModel):
    sum_count: int
    text: str

@app.get("/")
def read_root():
    return {"Hey! I'm rrrrind!"}

@app.get("/{sum_count}/{text}")
def read_item(sum_count: int, text: str):
    return es.preprocessed_lexrank(text, sum_count=sum_count)

@app.post("/summary/")
async def post_summary(summary: Summary):
    result = es.preprocessed_lexrank(summary.text, sum_count=summary.sum_count)
    return { "summary": result }
