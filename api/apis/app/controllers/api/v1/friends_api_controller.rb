require 'statsample' # 相関係数計算Gem
class Api::V1::FriendsApiController < ApplicationController
  
  # 友達をレコメンドする
  def recommend
    # 自分のユーザーID
    my_user_id = params[:user_id]
    me = User.find(my_user_id)
    # 自分以外のユーザーを全て取得
    friends = User.where.not(id: my_user_id)

    # 自分のデータ整理
    my_scores = me.user_hangout_results.order(:hangout_id)
    my_data = []
    for my_score in my_scores
      my_data << my_score.result
    end

    # 他のユーザーのデータ整理
    friends_data = []
    for friend in friends
      friend_scores = friend.user_hangout_results.order(:hangout_id)
      friend_data = []
      for friend_score in friend_scores
        friend_data << friend_score.result
      end
      friends_data << { user_id: friend.id, name:friend.name, profile: friend.profile, data: friend_data }
    end
    
    # 相関係数計算
    result = []
    for friend in friends_data
      score = Statsample::Bivariate::Pearson.new(my_data.to_vector, friend[:data].to_vector)
      result << { user_id: friend[:user_id], name: friend[:name], profile: friend[:profile], score: score.r }
    end
    result = result.sort_by { |a| a[:score]  }.reverse
    render json: result
  end

end
