# frozen_string_literal: true
class DropRequests < ActiveRecord::Migration
  def change
    drop_table :requests
  end
end
