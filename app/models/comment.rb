class Comment < ActiveRecord::Base
  attr_accessible :content, :body, :movie_id, :name
  before_save :convert_markdown

  belongs_to :movie

  private

  def convert_markdown
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       :autolink => true, :space_after_headers => true)
    self.content = markdown.render(self.body)
  end
end
