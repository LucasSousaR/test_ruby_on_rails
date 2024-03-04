require 'rails_helper'

RSpec.describe MunicipesController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new município' do
        expect {
          post :create, params: { municipe: attributes_for(:municipe) }
        }.to change(Municipe, :count).by(1)
      end

      it 'redirects to the created município' do
        post :create, params: { municipe: attributes_for(:municipe) }
        expect(response).to redirect_to(Municipe.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new município' do
        expect {
          post :create, params: { municipe: attributes_for(:municipe, nome_completo: nil) }
        }.to_not change(Municipe, :count)
      end

      it 'renders the new template' do
        post :create, params: { municipe: attributes_for(:municipe, nome_completo: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let(:municipe) { create(:municipe) }

    context 'with valid params' do
      it 'updates the requested municipe' do
        patch :update, params: { id: municipe.id, municipe: { nome_completo: 'Novo Nome' } }
        municipe.reload
        expect(municipe.nome_completo).to eq('Novo Nome')
      end

      it 'redirects to the municipe' do
        patch :update, params: { id: municipe.id, municipe: { nome_completo: 'Novo Nome' } }
        expect(response).to redirect_to(municipe)
      end
    end

    context 'with invalid params' do
      it 'does not update the municipe' do
        patch :update, params: { id: municipe.id, municipe: { nome_completo: nil } }
        municipe.reload
        expect(municipe.nome_completo).to_not be_nil
      end

      it 'renders the edit template' do
        patch :update, params: { id: municipe.id, municipe: { nome_completo: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

end