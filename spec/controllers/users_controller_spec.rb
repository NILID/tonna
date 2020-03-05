require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'admin activities should' do
    login_user(:admin)

    it 'index' do
      expect(@ability.can? :index, Project).to be true
      expect(get :index).to render_template(:index)
    end
  end

  describe 'unreg user activities should' do
    describe 'not' do
      after(:each)    { expect(response).to redirect_to(root_path) }
      it('get index') {
        get :index
        expect(flash[:alert]).not_to be_nil
      }
    end
  end

end
