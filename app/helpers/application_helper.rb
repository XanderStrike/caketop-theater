module ApplicationHelper

  def format_num n
    n.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
  end
end
