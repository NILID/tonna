require 'rails_helper'

describe ClientsController do
  let!(:client) { create(:client) }

  describe 'admin activities should' do
    login_user(:admin)

    it 'new' do
      expect(@ability.can? :new, Client).to be true
      expect(get :new).to render_template(:new)
    end

    it 'create' do
      expect(@ability.can? :create, Client).to be true
      expect{ post :create, params: { client: attributes_for(:client) } }.to change(Client, :count).by(1)
      expect(response).to redirect_to(assigns(:client))
    end

    it 'edit' do
      expect(@ability.can? :edit, client).to be true
      expect(get :edit, params: { id: client }).to render_template(:edit)
    end

    it 'update' do
      expect(@ability.can? :update, client).to be true
      put :update, params: { id: client, client: attributes_for(:client) }
      expect(response).to redirect_to(assigns(:client))
    end

    it 'destroy' do
      expect(@ability.can? :destroy, client).to be true
      expect{ delete :destroy, params: { id: client } }.to change(Client, :count).by(-1)
      expect(response).to redirect_to(clients_path)
    end

    it 'index' do
      expect(@ability.can? :index, Client).to be true
      expect(get :index).to render_template(:index)
      expect(assigns(:clients)).not_to be_empty
    end
  end

  [:user].each do |role|
    describe "user with #{role} role activities should" do
      login_user(role)

      it 'not new' do
        expect(@ability.can? :new, Client).to be false
        expect{ get :new }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not create' do
        expect(@ability.can? :create, Client).to be false
        expect{ post :create, params: { client: attributes_for(:client) } }.to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Client, :count).by(0)
      end

      it 'not edit' do
        expect(@ability.can? :edit, client).to be false
        expect{ get :edit, params: { id: client } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not update' do
        expect(@ability.can? :update, client).to be false
        expect{ put :update, params: { id: client, client: attributes_for(:client) } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not destroy' do
        expect(@ability.cannot? :destroy, client).to be true
        expect{ delete :destroy, params: { id: client } }.to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Client, :count).by(0)
      end

      it 'can index' do
        expect(@ability.can? :index, Client).to be false
        expect{ get :index }.to raise_error(CanCan:: AccessDenied)
      end
    end
  end

  describe 'unreg user activities should' do
    describe 'not' do
      after(:each) do
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).not_to be_nil
      end

      it('get index') { get :index }
      it('get new')   { get :new }
      it('create')    { expect{ post :create, params: { client: attributes_for(:client) } }.to change(Client, :count).by(0) }
      it('get edit')  { get :edit, params: { id: client } }
      it('update')    { put :update, params: { id: client, client: attributes_for(:client) } }
      it('destroy')   { expect{ delete :destroy, params: { id: client } }.to change(Client, :count).by(0) }
    end
  end
end
