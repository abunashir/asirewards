class AddFeaturedToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :featured, :boolean, default: false
  end
end
