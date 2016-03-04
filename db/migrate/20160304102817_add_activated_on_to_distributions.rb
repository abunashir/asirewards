class AddActivatedOnToDistributions < ActiveRecord::Migration
  def change
    add_column :distributions, :activated_on, :date
  end
end
