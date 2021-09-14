# 文区切り
import functools
from ja_sentence_segmenter.common.pipeline import make_pipeline
from ja_sentence_segmenter.concatenate.simple_concatenator import concatenate_matching
from ja_sentence_segmenter.normalize.neologd_normalizer import normalize
from ja_sentence_segmenter.split.simple_splitter import split_newline, split_punctuation
# クリーニング
from extractive_summarization import data_cleaning as dc
# 名詞/形容詞/副詞/動詞のみを抽出 かつ 形態素解析の実行ライブラリ
import re
import mecabpr
MECAB_IPADIC_NEOLOGD = '-r /etc/mecabrc -d /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd'
# 抽出型要約モデル(LexRank)
from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.tokenizers import Tokenizer
from sumy.summarizers.lex_rank import LexRankSummarizer


# main
def preprocessed_lexrank(text, sum_count):
    sentences = separate_sentences(text)
    sentences_dc = dc.data_cleaning(sentences)
    sentence_words = separate_words(sentences_dc)
    if sum_count != 0:
        return sum_text(sentences, sentence_words, sum_count=sum_count)
    if sum_count == 0:
        num, stock = 2, 0
        while 1:
            targ = sum_text(sentences, sentence_words, sum_count=num)
            if (len(targ) > 140) and (num == 2) :
                return sum_text(sentences, sentence_words, sum_count=1)
            elif len(targ) < 140 : 
                stock = targ
                num += 1
            elif len(targ) > 140:
                return stock
            else:
                return "unanticipated process"


# 文区切り
def separate_sentences(text):
    split_punc2 = functools.partial(split_punctuation, punctuations=r"。.．!！?？")
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
        ma = sum(mpr.findall(sentence, "(名詞|形容詞|副詞|動詞)", raw=True), [])
        # 活用形の統一(基本形へ)
        sentence_ma = []
        for word in ma:
            if word.split(',')[6] == "*":
                if not bool(re.search(r'[a-zA-Z]',word.split('\t')[0])):
                    wat = word.split('\t')[0] # word after transformation
                else :
                    wat = re.sub(r"[a-zA-Z]", "", word.split('\t')[0])
            elif bool(re.search(r'[a-zA-Z]',word.split(',')[6])):
                if not bool(re.search(r'[a-zA-Z]',word.split(',')[7])):
                    wat = word.split(',')[7] 
                else :
                    wat = re.sub(r"[a-zA-Z]", "", word.split(',')[6])
            else:
                wat = word.split(',')[6]
            sentence_ma.append(wat)
        sentence_words.append(sentence_ma)
    return sentence_words
    
    
# 文章要約メソッド
def sum_text(sentences_org, corpus, sum_count):
    sentences = [' '.join(sentence) + u'。' for sentence in corpus]
    for i, sentence in enumerate(sentences):
        sentences[i] = sentence.strip() # 前後の空白を削除(先頭に英単語があると空白が入ってエラーが出る)
    text_prep = "".join(sentences)
    parser = PlaintextParser.from_string(text_prep, Tokenizer('japanese'))

    summarizer = LexRankSummarizer()
    summarizer.stop_words = [''] # 単語と単語の間に半角スペース有り

    summary = summarizer(document=parser.document, sentences_count=sum_count)
    
    b = []
    for sentence in summary:
        b.append(sentences_org[sentences.index("{}".format(sentence.__str__()))])
        b.append("\n")
    return "".join(b)