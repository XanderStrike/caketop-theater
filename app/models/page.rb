class Page < ActiveRecord::Base
  scope :navbar, -> { where(navbar: true) }
  scope :footer, -> { where(footer: true) }

  def content
    markdown.render(text)
  end

  private

  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                          :autolink => true, :space_after_headers => true)
  end

end
