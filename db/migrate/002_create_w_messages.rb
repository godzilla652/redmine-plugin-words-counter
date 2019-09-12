class CreateWMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :w_messages do |t|
      t.text :body
    end
  end
end
