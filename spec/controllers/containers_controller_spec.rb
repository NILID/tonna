require 'rails_helper'

describe ContainersController do
  let!(:project)   { create(:project, :with_preview) }
  let!(:container) { create(:container, project: project) }

  describe 'admin activities should' do
    login_user(:admin)

    it 'edit' do
      expect(@ability.can? :edit, container).to be true
      expect(get :edit, params: { id: container, project_id: project }).to render_template(:edit)
    end

    it 'update' do
      expect(@ability.can? :update, container).to be true
      put :update, params: { id: container, project_id: project, container: attributes_for(:container) }
      expect(response).to redirect_to(assigns(:container).project)
    end

    it 'destroy' do
      expect(@ability.can? :destroy, container).to be true
      expect{ delete :destroy, params: { id: container, project_id: project }, xhr: true }.to change(Container, :count).by(-1)
    end
  end

  [:user].each do |role|
    describe "user with #{role} role activities should" do
      login_user(role)

      it 'edit' do
        expect(@ability.can? :edit, container).to be false
        expect{ get :edit, params: { id: container, project_id: project } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'update' do
        expect(@ability.can? :update, container).to be false
        expect{ put :update, params: { id: container, project_id: project, container: attributes_for(:container) } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not destroy' do
        expect(@ability.cannot? :destroy, container).to be true
        expect{ delete :destroy, params: { id: container, project_id: project }, xhr: true }.to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Container, :count).by(0)
      end
    end
  end

  describe 'unreg user activities should' do
    describe 'not' do
      after(:each) do
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).not_to be_nil
      end

      it('get new')  { get :new, params: { project_id: project } }
      it('create')   { expect{ post :create, params: { container: attributes_for(:container), project_id: project } }.to change(Container, :count).by(0) }
      it('get edit') { get :edit, params: { id: container, project_id: project } }
      it('update')   { put :update, params: { id: container, project_id: project, container: attributes_for(:container) } }
      it('destroy')  { expect{ delete :destroy, params: { id: container, project_id: project } }.to change(Container, :count).by(0) }
    end
  end
end
