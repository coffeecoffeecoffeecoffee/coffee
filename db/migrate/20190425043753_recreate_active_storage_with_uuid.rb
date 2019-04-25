# This migration comes from active_storage (originally 20170806125915)
class RecreateActiveStorageWithUuid < ActiveRecord::Migration[5.2]
  def change
    drop_table :active_storage_attachments do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.bigint "blob_id", null: false
      t.datetime "created_at", null: false
      t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
      t.index %w[record_type record_id name blob_id], name: "index_active_storage_attachments_uniqueness", unique: true
    end

    drop_table :active_storage_blobs do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.bigint "byte_size", null: false
      t.string "checksum", null: false
      t.datetime "created_at", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
    end

    ## Drop first, then recreate using UUID

    create_table :active_storage_blobs, id: :uuid do |t|
      t.string   :key,        null: false
      t.string   :filename,   null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

      t.index [:key], unique: true
    end

    create_table :active_storage_attachments, id: :uuid do |t|
      t.string :name, null: false
      t.uuid :record_id, null: false
      t.string :record_type, null: false
      t.uuid :blob_id, null: false

      t.datetime :created_at, null: false

      t.index %i[record_type record_id name blob_id], name: "index_active_storage_attachments_uniqueness", unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end
  end
end
