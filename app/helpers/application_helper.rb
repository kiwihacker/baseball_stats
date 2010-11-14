module ApplicationHelper
  
  def title
    base_title = "Tokyo Eagles"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
end
