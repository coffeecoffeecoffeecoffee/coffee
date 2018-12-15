class AllowNullValuesInVenue < ActiveRecord::Migration[5.2]
  def change
    change_column_null :venues, :name, true
    change_column_null :venues, :foursquare_url, true
    change_column_null :venues, :image_url, true
  end
end
