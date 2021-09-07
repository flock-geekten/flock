from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

# 抽出型文書要約モデル(LexRank)
from extractive_summarization import extractive_summarization as es
# キーフレーズ抽出モデル(YAKE!)
from keyphrase_extraction import keyphrase_extraction as ke


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


class Summary(BaseModel):
    sum_count: int
    text: str

@app.get("/summary/{sum_count}/{text}")
def read_item(sum_count: int, text: str):
    return es.preprocessed_lexrank(text, sum_count=sum_count)

@app.post("/summary/")
async def post_summary(summary: Summary):
    result = es.preprocessed_lexrank(summary.text, sum_count=summary.sum_count)
    return { "summary": result }


class Keyphrase(BaseModel):
    get_key_num: int
    text: str

@app.get("/keyphrase/{get_key_num}/{text}")
def read_item(get_key_num: int, text: str):
    return ke.preprocessed_yake(text, get_key_num=get_key_num)

@app.post("/keyphrase/")
async def post_summary(keyphrase: Keyphrase):
    result = ke.preprocessed_yake(keyphrase.text, get_key_num=keyphrase.get_key_num)
    return { "keyphrase": result }