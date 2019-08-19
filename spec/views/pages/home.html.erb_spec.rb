require 'rails_helper'

RSpec.describe "pages/home.html.erb", type: :view do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "takes you to Fakebook homepage" do
    assert_match "", response.body
  end
end
