require 'rails_helper'

describe NotesController do
  let!(:note) { create(:note) }

  describe 'admin activities should' do
    login_user(:admin)

    it 'list' do
      expect(@ability.can? :list, Note).to be true
      expect(get :list).to render_template(:list)
      expect(assigns(:notes)).not_to be_empty
    end

    it 'destroy' do
      expect(@ability.can? :destroy, note).to be true
      expect{ delete :destroy, params: { id: note } }.to change(Note, :count).by(-1)
      expect(response).to redirect_to(notes_path)
    end
  end

  %i[admin user].each do |role|
    describe "user with #{role} role activities should" do
      login_user(role)

      it 'index' do
        expect(@ability.can? :index, Note).to be true
        expect(get :index).to render_template(:index)
      end

      it 'create' do
        expect(@ability.can? :create, Note).to be true
        expect{ post :create, params: { note: attributes_for(:note) } }.to change(Note, :count).by(1)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  [:user].each do |role|
    describe "user with #{role} role activities should" do
      login_user(role)

      it 'not list' do
        expect(@ability.cannot? :list, Note).to be true
        expect{ get :list }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not destroy' do
        expect(@ability.cannot? :destroy, note).to be true
        expect{ delete :destroy, params: { id: note } }.to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Note, :count).by(0)
      end
    end
  end

  describe 'unreg user activities should' do
    it 'create' do
      expect{ post :create, params: { note: attributes_for(:note) } }.to change(Note, :count).by(1)
      expect(response).to redirect_to(root_path)
    end

    it 'index' do
      expect(get :index).to render_template(:index)
    end

    describe 'not' do
      after(:each) do
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).not_to be_nil
      end

      it('list')   { get :list }
      it('destroy') { expect{ delete :destroy, params: { id: note } }.to change(Note, :count).by(0) }
    end
  end
end
