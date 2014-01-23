class AddDocumentUrlToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :document_url, :string
  end
end
