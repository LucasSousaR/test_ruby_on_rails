require 'rails_helper'

RSpec.describe Municipe, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      should validate_presence_of(:nome_completo)
      should validate_presence_of(:cpf)
      should validate_presence_of(:cns)
      should validate_presence_of(:email)
      should validate_presence_of(:data_nascimento)
      should validate_presence_of(:telefone)
      should validate_presence_of(:status)
    end

    it 'validates format of email' do
      should allow_value('test@example.com').for(:email)
      should_not allow_value('invalid_email').for(:email)
    end
  end

  describe 'associations' do
    it 'has one endereco' do
      should have_one(:endereco)
    end
  end
end