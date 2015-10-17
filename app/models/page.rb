class Page < ActiveRecord::Base
  scope :navbar, -> { where(navbar: true) }
  scope :footer, -> { where(footer: true) }

  private

  def convert_markdown
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       :autolink => true, :space_after_headers => true)
    self.content = markdown.render(self.text)
  end

end
