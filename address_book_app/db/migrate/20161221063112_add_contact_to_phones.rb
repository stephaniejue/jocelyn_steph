class AddContactToPhones < ActiveRecord::Migration
  def change
    add_reference :phones, :contact, index: true, foreign_key: {on_delete: :restrict, on_update: :restrict}
  end
end
