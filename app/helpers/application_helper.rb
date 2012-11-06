# encoding: UTF-8
module ApplicationHelper
  def title(s = nil)
    @page_title = block_given? ? yield : s
  end
end
