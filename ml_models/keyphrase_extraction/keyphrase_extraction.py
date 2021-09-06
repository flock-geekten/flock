import numpy as np

# 文区切り
import functools
from ja_sentence_segmenter.common.pipeline import make_pipeline
from ja_sentence_segmenter.concatenate.simple_concatenator import concatenate_matching
from ja_sentence_segmenter.normalize.neologd_normalizer import normalize
from ja_sentence_segmenter.split.simple_splitter import split_newline, split_punctuation
# クリーニング
from keyphrase_extraction import data_cleaning as dc
# 名詞-固有名詞|名詞-一般|名詞-サ変接続|名詞-形容動詞語幹のみを抽出 かつ 形態素解析の実行ライブラリ
import re
import mecabpr
MECAB_IPADIC_NEOLOGD = '-r /etc/mecabrc -d /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd'
# キーフレーズ抽出モデル(YAKE!)
import yake
from yake import KeywordExtractor


# main
def preprocessed_yake(text, get_key_num=10):
    sentences = separate_sentences(text)
    sentences_dc = dc.data_cleaning(sentences)
    sentence_words = separate_words(sentences_dc)
    return apply_yake(sentences, sentence_words, get_key_num=get_key_num)


# 文区切り
def separate_sentences(text):
    split_punc2 = functools.partial(split_punctuation, punctuations=r"。.!！?？")
    concat_tail_te = functools.partial(concatenate_matching, 
                                       former_matching_rule=r"^(?P<result>.+)([\r\n]+)$", 
                                       remove_former_matched=False)
    segmenter = make_pipeline(normalize, split_newline, concat_tail_te, split_punc2)
    return list(segmenter(text))


# 文章の単語分割，単語の正規化，ストップワード除去
def separate_words(sentences):
    mpr = mecabpr.MeCabPosRegex(MECAB_IPADIC_NEOLOGD)
    
    sentence_words = []
    for i, sentence in enumerate(sentences):
        # 名詞|形容詞|副詞|動詞のみの抽出
        ma = sum(mpr.findall(sentence, "(名詞-固有名詞|名詞-一般|名詞-サ変接続|名詞-形容動詞語幹)", raw=True), [])
        # 活用形の統一(基本形へ)
        sentence_ma = []
        for word in ma:
            if word.split(',')[6] == "*":
                wat = word.split('\t')[0] # word after transformation
            else:
                wat = word.split(',')[6]
            sentence_ma.append(wat)
        sentence_words.append(sentence_ma)
    return _tyoonpu_encoder(sentence_words)


# 長音符があると，YAKE!内の分かち書きで何故か分割されてしまうので，ハイフンに置き換える
def _tyoonpu_encoder(sentence_words):
    for i, sentence in enumerate(sentence_words):
        for j, word in  enumerate(sentence):
            if "ー" in word:
                sentence_words[i][j] = word.replace("ー","-")
            if re.search(r'\d', word):
                sentence_words[i][j] = ""
    return sentence_words


# 置き換えたハイフンを長音符に戻す
def _tyoonpu_decoder(keywords):
    for i, word in enumerate(keywords):
        if "-" in word:
            keywords[i] = word.replace("-","ー")
    return keywords
    
    
# キーフレーズ抽出メソッド
def apply_yake(sentences_org, corpus, get_key_num=10):
    sentences = [' '.join(sentence) + u'. ' for sentence in corpus]
    text_prep = "".join(sentences)
    
    language = "ja" # 日本語に対応．
    max_ngram_size = 1 # 最高1単語まで．2単語以上だと意味がわからなくなる．
    deduplication_thresold = 0.5 # 重複単語への制約．小さい方が重複単語が選ばれない．

    custom_kw_extractor = yake.KeywordExtractor(
        lan="ja", n=1, dedupLim=deduplication_thresold, top=get_key_num, features=None)
    keywords = custom_kw_extractor.extract_keywords(text_prep) 
    # [('ラ-メン屋', 0.20158754930236147), ('おこじょ', 0.42630873882977355), ('個人的', 0.4755448896136777),…]
    keywords = np.array(keywords)[:,0].tolist() # ['ラ-メン屋', 'おこじょ', '個人的', …]
    return _tyoonpu_decoder(keywords) # ラ-メン屋 → ラーメン屋
