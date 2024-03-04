class Municipe < ApplicationRecord

  belongs_to :municipio


  validates :nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :foto, presence: true
  validates :cpf, cpf: true
  validates :cns, format: { with: /\A\d{15}\z/, message: "deve ter 15 dígitos" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :data_nascimento_valida
  validates :cep, :logradouro, :bairro, :cidade, :uf, presence: true
  validates :cep, format: { with: /\A\d{5}-\d{3}\z/, message: "deve estar no formato 12345-123" }
  validates :uf, length: { is: 2, message: "deve ter 2 caracteres" }
  validates :codigo_ibge, numericality: { only_integer: true, allow_blank: true }

  def data_nascimento_valida
    errors.add(:data_nascimento, "inválida") if data_nascimento.present? && data_nascimento > Date.today
  end

  has_one :endereco
  accepts_nested_attributes_for :endereco
  has_one_attached :photo do |attachable|
    attachable.variant :small, resize: "200x200"
    attachable.variant :medium, resize: "400x400"
    attachable.variant :medium, resize: "600x600"
    # Adicione mais variantes conforme necessário
  end

end
