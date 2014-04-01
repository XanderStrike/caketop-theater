class Feedback < ActiveRecord::Base
  attr_accessible :content, :ip, :name, :path
end
