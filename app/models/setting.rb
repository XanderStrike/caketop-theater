class Setting < ActiveRecord::Base
  attr_accessible :name, :id, :content, :number, :boolean

  def self.get name
    Setting.where(name: name).first
  end
end
