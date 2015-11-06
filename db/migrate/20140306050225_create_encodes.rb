class CreateEncodes < ActiveRecord::Migration
  def change
    create_table :encodes do |t|
      t.string :container
      t.string :size
      t.string :duration
      t.string :rip_date
      t.string :v_format
      t.string :v_profile
      t.string :v_codec
      t.string :resolution
      t.string :aspect_ratio
      t.string :v_bitrate
      t.string :framerate
      t.string :v_stream_size
      t.string :a_format
      t.string :a_bitrate
      t.string :a_stream_size
      t.integer :movie_id

      t.timestamps
    end
  end
end
