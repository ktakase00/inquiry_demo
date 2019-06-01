class CreateExAccepts < ActiveRecord::Migration[5.2]
  def change
    create_table :ex_accepts, { id: :bigserial } do |t|
      t.text :inquiry_cd, null: false, default: ''
      t.column :accept_count, :bigint, null: false, default: 0

      t.column :created_at, :timestamptz, null: false
      t.column :updated_at, :timestamptz, null: false
    end
  end
end
