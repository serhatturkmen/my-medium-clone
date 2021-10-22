module ApplicationHelper
  def substr(description)
    # choices
    # description.size < 100 ? description : "#{description[0..100]}..."
    # description[0..30].gsub(/\s\w+\s*$/, '...')
    truncate(description, :length => 100)
  end

  def comment_status_text(comment_status)
    if comment_status == 0
      'No process'
    elsif comment_status == 1
      'Accepted'
    else
      'Declined'
    end
  end
end
