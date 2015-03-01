class Page < ActiveRecord::Base
  include HTMLRenderer

  attr_accessible :text, :content, :name, :navbar, :footer
  before_save :convert_markdown

  scope :navbar, -> { where(navbar: true) }
  scope :footer, -> { where(footer: true) }

  private

  def convert_markdown
    self.content = red_carpet.render(self.text)
  end

end
