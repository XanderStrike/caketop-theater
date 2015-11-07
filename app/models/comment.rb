class Comment < ActiveRecord::Base
  before_save :convert_markdown

  belongs_to :movie

  private

  def convert_markdown
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       autolink: true, space_after_headers: true)
    self.content = markdown.render(body)
  end
end
