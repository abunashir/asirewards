class AddBannerToContents < ActiveRecord::Migration
  def change
    add_column :contents, :banner, :text
  end
end
