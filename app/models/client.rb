class Client < ApplicationRecord

  validates :title, presence: true
  validates :url, uniqueness: true, presence: true
  validates :email, email: true, presence: true

  def self.make_parse
     p = "https://vpodolske.com/spravochnik/organizations/emails"
     page = Nokogiri::HTML(open(p.to_s))

     page.css('.organization').each do |link|
       source = link.at_css('.o-url').text
       new_client = Client.new(url: source)
       new_client.valid?
       new_client.build_from_source(source, link) if new_client.errors[:url].empty?
     end
  end

  def build_from_source(source, link)
    c = Client.new(
                   title:       link.at_css('.o-title').text,
                   email:       link.at_css('.o-email').text,
                   phone:       link.at_css('.o-phone').text,
                   site:        link.at_css('.o-site').text,
                   categories:  link.at_css('.o-categories').text,
                   url:         link.at_css('.o-url').text
                  )

    c.save! if c.valid?
  end
end
