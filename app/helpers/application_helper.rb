module ApplicationHelper
  def on_home_page?
    current_page?(root_path)
  end
end
