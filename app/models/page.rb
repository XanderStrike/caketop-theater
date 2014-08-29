class Page < ActiveRecord::Base
  attr_accessible :text, :content, :name, :navbar, :footer
  before_save :convert_markdown

  scope :navbar, -> { where(navbar: true) }

  private

  def convert_markdown
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       :autolink => true, :space_after_headers => true)
    self.content = markdown.render(self.text)
  end

end
