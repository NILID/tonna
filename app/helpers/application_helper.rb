include Pagy::Frontend

module ApplicationHelper
  def mail_to_tonna
    mail_to('info@tonna.studio', nil, replace_at: '_at_', replace_dot: '_dot_', encode: 'hex')
  end

  def social_link(soc_name)
    socials = {
      instagram: 'https://www.instagram.com/tonna.studio',
             vk: 'https://vk.com/tonna.studio',
       facebook: 'https://www.facebook.com/tonna.studio',
        twitter: 'https://twitter.com/tonna_studio',
        behance: 'https://www.behance.net/tonna_studio',
       telegram: 'https://t.me/tonna_studio'
    }
    link = socials[soc_name]
    link == nil ? raise(ArgumentError.new("No social link in list for #{soc_name}")) : link
  end

  def lazy_image_tag(img)
    image_tag(img, class: 'img-responsive b-lazy', data: { src: img, src_small: img })
  end
end
