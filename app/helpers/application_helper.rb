module ApplicationHelper
  include Pagy::Frontend

  def time_display(time)
    if time > 7.days.ago
     return "#{time_ago_in_words(time)} ago"
    else
      time.in_time_zone("Central Time (US & Canada)").strftime("%m/%d/%y at %I:%M %p")
    end
  end

end
