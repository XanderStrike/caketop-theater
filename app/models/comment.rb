class Comment < ActiveRecord::Base
  attr_accessible :body, :movie_id, :name

  belongs_to :movie

  def body_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       :autolink => true)
    markdown.render(ActionView::Base.full_sanitizer.sanitize(self.body))
  end
end
