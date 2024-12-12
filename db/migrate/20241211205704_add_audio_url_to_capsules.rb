class AddAudioUrlToCapsules < ActiveRecord::Migration[7.1]
  def change
    add_column :capsules, :audio_url, :string
  end
end
