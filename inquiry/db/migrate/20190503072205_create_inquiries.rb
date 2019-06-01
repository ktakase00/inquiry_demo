class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries, { id: :bigserial } do |t|
      t.column :inquiry_at, :timestamptz, null: false
      t.text :inquiry_cd, null: false, default: ''
      t.text :inquiry_content, null: false, default: ''
      t.text :accept_cd, null: false, default: ''
      t.column :error_json, :jsonb, null: false, default: {}

      t.column :created_at, :timestamptz, null: false
      t.column :updated_at, :timestamptz, null: false
    end
  end
end
