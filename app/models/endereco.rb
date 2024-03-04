class Endereco < ApplicationRecord
  belongs_to :municipe

  validates :cep, :logradouro, :bairro, :cidade, :uf, presence: true
  validates :cep, format: { with: /\A\d{5}-\d{3}\z/, message: "deve estar no formato 12345-123" }
  validates :uf, length: { is: 2, message: "deve ter 2 caracteres" }
  validates :codigo_ibge, numericality: { only_integer: true, allow_blank: true }
end
