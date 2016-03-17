class AddSlugToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :slug, :string
  end
end
