class AddConferenceUrlToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :conference_url, :string
  end
end
