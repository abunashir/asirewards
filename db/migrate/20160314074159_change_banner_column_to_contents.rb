class ChangeBannerColumnToContents < ActiveRecord::Migration
  def change
    change_column :contents, :banner, :string
  end
end
