class AddPictureToChefs < ActiveRecord::Migration
  def change
    add_column :chefs, :picture, :string
  end
end
