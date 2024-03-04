class CreateMunicipes < ActiveRecord::Migration[5.2]
  def change
    create_table :municipes do |t|

      t.string :nome_completo
      t.string :cpf
      t.string :cns
      t.string :email
      t.date :data_nascimento
      t.string :telefone
      t.string :foto
      t.boolean :status, default: true
      t.references :municipio, null: false, foreign_key: true
      t.timestamps
    end
  end
end
