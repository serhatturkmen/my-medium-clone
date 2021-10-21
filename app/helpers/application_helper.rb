module ApplicationHelper
  def substr(description)
    # choices
    # description.size < 100 ? description : "#{description[0..100]}..."
    # description[0..30].gsub(/\s\w+\s*$/, '...')
    truncate(description, :length => 100)
  end
end
