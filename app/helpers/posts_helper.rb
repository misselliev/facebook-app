# frozen_string_literal: true

module PostsHelper
  def post_owner?(post)
    current_user == post.author
  end
end
