class Page < ActiveRecord::Base
  def attributes
    super.merge(
      'url' => "html_page?name=#{URI.encode(self.name)}"
    )
  end
end
