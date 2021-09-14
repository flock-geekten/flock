import re
import emoji
import neologdn
import requests
import unicodedata

def data_cleaning(data):
    return [text_cleaning(text) for text in data]

def text_cleaning(text):
    text = clean_text(text)
    text = clean_url(text)
    text = normalize(text)
    print(text)
    return text

def clean_text(text):
    replaced_text = text.lower()
    replaced_text = neologdn.normalize(replaced_text)    # 『楽しみ〜〜〜』の『〜〜〜』などを削除
    replaced_text = re.sub(r'　', ' ', replaced_text)  # 全角空白の除去
    replaced_text = remove_emoji(replaced_text) # 絵文字の削除
    replaced_text = replaced_text.replace('．', '。').replace('，', '、').replace(',', '、')
    return replaced_text

def remove_emoji(text):
    return ''.join(c for c in text if c not in emoji.UNICODE_EMOJI)

def clean_url(html_text):
    cleaned_text = re.sub(r'http\S+', '', html_text)
    cleaned_text = re.sub(r'https\S+', '', cleaned_text)
    return cleaned_text

def normalize(text):
    normalized_text = normalize_unicode(text) # 全角半角などの統一
    normalized_text = delete_symbol(text) # 記号の削除(顔文字対策)
    normalized_text = normalize_number(normalized_text) # 数字を全て0に
    normalized_text = lower_text(normalized_text) # 小文字に統一
    return normalized_text

def normalize_unicode(text, form='NFKC'):
    normalized_text = unicodedata.normalize(form, text)
    return normalized_text

def delete_symbol(text):
    code_regex = re.compile('[\t\s!"#$%&\'\\\\()*+,-./:;；：<=>?@[\\]^_`{|}~○｢｣「」〔〕“”〈〉'\
                            '『』【】＆＊（）＄＃＠？！｀＋￥¥％♪…◇→←↓↑｡。、･ω･｡ﾟ´∀｀ΣДｘ⑥◎©︎♡★☆▽※ゞノ〆εσ＞＜┌┘]')
    return code_regex.sub('', text)

def normalize_number(text):
    replaced_text = re.sub(r'\d+', '0', text)
    return replaced_text

def lower_text(text):
    return text.lower()