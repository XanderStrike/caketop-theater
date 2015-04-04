class Comment < ActiveRecord::Base
  include HTMLRenderer

  attr_accessible :content, :body, :movie_id, :name
  before_save :convert_markdown

  belongs_to :movie

  private

  def convert_markdown
    self.content = red_carpet.render(self.body)
  end
end
