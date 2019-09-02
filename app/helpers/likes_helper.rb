module LikesHelper
  def liked?(post)
    !current_user.likes.find_by(post_id: post)
  end

end
