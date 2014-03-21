class Request < ActiveRecord::Base
  attr_accessible :desc, :id, :ip, :link, :name
end
