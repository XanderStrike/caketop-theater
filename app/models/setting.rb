class Setting < ActiveRecord::Base
  attr_accessible :name, :id, :content, :number, :boolean

  def self.render name
  	if get(name).boolean
      return get(name).content.html_safe
    else
      return ''
  	end
  end

  def self.get name
    Setting.find_by_name(name)
  end
end
