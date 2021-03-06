import numpy as np
import pandas as pd

# ガウス過程回帰
import GPy

# 正規化
from sklearn.preprocessing import MinMaxScaler

# 多重対応分析の結果のcsvの保存場所
FUN_FEATURES = '/home/workspace/recommendation_models/data/fun_data.csv'


def run(y_json, is_sorted=1):
    
    fun_name, fun_features = _get_datasets(y_json)
    df_y = _json2dataframe(y_json)
    x_train, y_train = _create_train_set(fun_features, df_y)
    y_pred = _calc_gpr(fun_features, x_train, y_train)
    df_eval_vals = _calc_eval_vals(y_pred)
    df_eval_vals = pd.concat([fun_name, df_eval_vals], axis=1)
    if is_sorted == 1:
        df_eval_vals_sorted = _sort_eval_vals(df_eval_vals)
        return to_json(df_eval_vals_sorted)
    return to_json(df_eval_vals)

def _get_datasets(y_json):
    fun_data = pd.read_csv(FUN_FEATURES, index_col=0)
    fun_name = pd.DataFrame(fun_data['name'])
    fun_features = fun_data.drop('name',axis=1)
    return fun_name, fun_features
     
def _json2dataframe(y_json):
    for i, one_json in enumerate(y_json):
        shaping_json = {"{}".format(i): one_json} 
        input_json = str(shaping_json).replace("'", '"')
        se_y = pd.read_json(input_json) # json to Series
        # 初回だけdfにseを代入し，2回目以降はdfとseを結合する
        df_y = se_y if i == 0 else pd.concat([df_y, se_y], axis=1)
    df_y  = df_y.reindex(index=y_json[0].keys()) # indexの順番をjsonと同じにする
    df_y.drop(['id'], inplace=True)
    return df_y.T


def _create_train_set(fun_features, df_y):
    x_train = fun_features.loc[df_y['hangout_id']]
    y_train = pd.DataFrame(df_y['fun_score'])
    return x_train, y_train


def _calc_gpr(fun_features, x_train, y_train):
    dim = len(x_train.columns)
    #kernel = GPy.kern.Matern32(dim) + GPy.kern.Linear(dim) + GPy.kern.Bias(dim) + GPy.kern.White(dim)
    #kernel = GPy.kern.RBF(dim) + GPy.kern.Linear(dim) + GPy.kern.Bias(dim) + GPy.kern.White(dim)
    kernel = GPy.kern.Matern32(dim) + GPy.kern.Bias(dim) + GPy.kern.White(dim)
    # モデルの学習
    model = GPy.models.GPRegression(x_train, y_train, kernel)
    model.optimize()
    # 予測結果
    y_qua_pred = model.predict_quantiles(fun_features.values, quantiles=(2.5, 50, 97.5))
    y_pred = pd.DataFrame(np.array(y_qua_pred).reshape(3,len(y_qua_pred[0])).T)
    y_pred.index = fun_features.index
    y_pred.columns = ["2.5%","expected value","97.5%"]
    return y_pred


def _calc_eval_vals(y_pred):
    expected_value = y_pred["expected value"]
    expected_value_mm = _calc_minmaxscaler(expected_value)
    variation = y_pred["97.5%"] - y_pred["2.5%"]
    variation_mm = _calc_minmaxscaler(variation)
    
    A = 0.5
    B = 1 - A
    # 期待値が高く,ばらつきが大きい(今までに経験してない)遊びをレコメンドしたい気持ちが込められてる
    eval_vals = A * expected_value_mm + B * variation_mm
    return pd.DataFrame(eval_vals, index=y_pred.index, columns=["eval_val"])
    

def _calc_minmaxscaler(values):
    input_values = values.values.reshape(-1,1)
    scaler = MinMaxScaler()
    return scaler.fit_transform(input_values)


def _sort_eval_vals(df_eval_vals):
    return df_eval_vals.sort_values("eval_val", ascending=False)

    
def to_json(results):   
    y_pred_json = []
    for i, score in enumerate(results["eval_val"].values.flatten()): 
        y_pred_json.append(
            dict( hangout_id = int(results.index[i]), 
                  fun_name = results["name"].iloc[i],
                  score = score))
    return y_pred_json
