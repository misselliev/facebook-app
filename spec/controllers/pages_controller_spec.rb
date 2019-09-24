# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'should get home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
      render_template 'Welcome to Fakebook app'
    end
  end
end
