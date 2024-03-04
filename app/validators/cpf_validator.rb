require 'cpf_cnpj'
class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless cpf_valid?(value)
      record.errors.add(attribute, :invalid_cpf, message: "não é válido")
    end
  end

  private

  def cpf_valid?(cpf)

    return CPF.valid?(cpf)
  end
end