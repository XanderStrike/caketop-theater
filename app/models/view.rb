# frozen_string_literal: true
class View < ActiveRecord::Base
  belongs_to :movie

  def hour
    created_at.localtime.strftime('%H')
  end

  def day_of_week
    created_at.localtime.strftime('%w')
  end
end
