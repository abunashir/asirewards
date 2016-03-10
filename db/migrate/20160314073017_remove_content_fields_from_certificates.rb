class RemoveContentFieldsFromCertificates < ActiveRecord::Migration
  def change
    remove_column :certificates, :banner, :string
    remove_column :certificates, :title, :text
    remove_column :certificates, :sub_title, :text
    remove_column :certificates, :terms, :text
    remove_column :certificates, :expires_on, :date
    remove_column :certificates, :policies, :text
  end
end
