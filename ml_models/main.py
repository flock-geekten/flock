from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

# str to list
import ast

# 抽出型文書要約モデル(LexRank)
from extractive_summarization import extractive_summarization as es
# キーフレーズ抽出モデル(YAKE!)
from keyphrase_extraction import keyphrase_extraction as ke
# 遊び特徴量抽出(多重対応分析)
from recommendation_models import multiple_correspondence_analysis as rm_mca
# 遊びレコメンドモデル(ガウス過程回帰)
from recommendation_models import fun_recommendation as rm_fr


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
async def post_keyphrase(keyphrase: Keyphrase):
    result = ke.preprocessed_yake(keyphrase.text, get_key_num=keyphrase.get_key_num)
    return { "keyphrase": result }


class MCA(BaseModel):
    playlist: str

@app.post("/mca/")
async def post_mca(mca: MCA):
    playlist = ast.literal_eval(mca.playlist)
    rm_mca.run(playlist)
    return {"status": "OK"}


class FunRecommendation(BaseModel):
    y_json: str
    is_sorted: int # 0:ソートしない，1:ソートする

@app.post("/fun_reco/")
async def post_fun_reco(fr: FunRecommendation):
    y_json = ast.literal_eval(fr.y_json)
    return rm_fr.run(y_json, fr.is_sorted)