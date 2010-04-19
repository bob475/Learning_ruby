# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "RoR"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}" #zavaruje stran pred tem da bi kdo uporabil title kot eno nevarno vsebino
    end
  end
  
  def logo
  logo = image_tag("logo.png", :alt => "Sample App", :class => "round")

  end
end
