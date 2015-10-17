class View < ActiveRecord::Base
  belongs_to :movie

  def hour
    self.created_at.localtime.strftime('%H')
  end

  def day_of_week
    self.created_at.localtime.strftime('%w')
  end
end
