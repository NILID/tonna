require 'rails_helper'

describe ProjectsController do
  let!(:project) { create(:project, :with_preview) }

  describe 'admin activities should' do
    login_user(:admin)

    it 'new' do
      expect(@ability.can? :new, Project).to be true
      expect(get :new).to render_template(:new)
    end

    it 'create' do
      expect(@ability.can? :create, Project).to be true
      expect{ post :create, params: { project: attributes_for(:project, :with_preview) } }.to change(Project, :count).by(1)
      expect(response).to redirect_to(assigns(:project))
    end

    it 'edit' do
      expect(@ability.can? :edit, project).to be true
      expect(get :edit, params: { id: project }).to render_template(:edit)
    end

    it 'update' do
      expect(@ability.can? :update, project).to be true
      put :update, params: { id: project, project: attributes_for(:project) }
      expect(response).to redirect_to(assigns(:project))
    end

    it 'destroy' do
      expect(@ability.can? :destroy, project).to be true
      expect{ delete :destroy, params: { id: project } }.to change(Project, :count).by(-1)
      expect(response).to redirect_to(projects_path)
    end

    it 'index' do
      expect(@ability.can? :index, Project).to be true
      expect(get :index).to render_template(:index)
      expect(assigns(:projects)).not_to be_empty
    end
  end

  [:user].each do |role|
    describe "user with #{role} role activities should" do
      login_user(role)

      it 'not new' do
        expect(@ability.can? :new, Project).to be false
        expect{ get :new }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not create' do
        expect(@ability.can? :create, Project).to be false
        expect{ post :create, params: { project: attributes_for(:project, :with_preview) } }.to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Project, :count).by(0)
      end


      it 'not edit' do
        expect(@ability.can? :edit, project).to be false
        expect{ get :edit, params: { id: project } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not update' do
        expect(@ability.can? :update, project).to be false
        expect{ put :update, params: { id: project, project: attributes_for(:project) } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not destroy' do
        expect(@ability.cannot? :destroy, project).to be true
        expect{ delete :destroy, params: { id: project } }.to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Project, :count).by(0)
      end

      it 'can index' do
        expect(@ability.can? :index, Project).to be true
      end

      it 'index empty if not shown list' do
        expect(Project.all).not_to be_empty
        expect(Project.where(hide: false)).to be_empty
        expect(get :index).to render_template(:index)
        expect(assigns(:projects)).to be_empty
      end

      it('index with not list if ')  {
        create(:project, :with_preview, hide: false)
        expect(Project.all).not_to be_empty
        expect(Project.where(hide: false)).not_to be_empty
        expect(@ability.can? :index, Project).to be true
        expect(get :index).to render_template(:index)
        expect(assigns(:projects)).not_to be_empty
      }
    end
  end

  describe 'unreg user activities should' do
    it('index with empty list if hide projects')  {
      expect(Project.all).not_to be_empty
      expect(Project.where(hide: false)).to be_empty
      expect(get :index).to render_template(:index)
      expect(assigns(:projects)).to be_empty
    }

    it('index with not list if ')  {
      create(:project, :with_preview, hide: false)
      expect(Project.all).not_to be_empty
      expect(Project.where(hide: false)).not_to be_empty
      expect(get :index).to render_template(:index)
      expect(assigns(:projects)).not_to be_empty
    }

    describe 'not' do
      after(:each) do
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).not_to be_nil
      end

      it('get new')  { get :new }
      it('create')   { expect{ post :create, params: { project: attributes_for(:project) } }.to change(Project, :count).by(0) }
      it('get edit') { get :edit, params: { id: project } }
      it('update')   { put :update, params: { id: project, project: attributes_for(:project) } }
      it('destroy')  { expect{ delete :destroy, params: { id: project } }.to change(Project, :count).by(0) }
    end
  end
end
