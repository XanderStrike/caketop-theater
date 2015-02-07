module ApplicationHelper

  def format_num n
    n.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
  end

  def sub_url
  	Setting.get(:url).content
  end
end
