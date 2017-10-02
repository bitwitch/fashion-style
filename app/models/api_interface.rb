require 'shopsense'

class ApiInterface < ApplicationRecord

  @@client = Shopsense::API.new({'partner_id' => 'uid401-39901049-24'})

  def self.ten_products(type)
    response = @@client.search(type)
    raw_products = JSON.parse(response)['products']
  end

  def self.products(type)
    response = @@client.search(type, 0, 50)
    raw_products = JSON.parse(response)['products']
  end

  def self.parse(response)
    response.map do |product|
      image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
      puts image.inspect
      {
        'name' => product["name"],
        'image' => image
      }
    end
  end

  def self.image_urls(style)
    if style[:type] == 'accessories'

      {
        accessories: style[:accessories_url],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: self.parse(self.products('pants')).sample['image']['url'],
        shoes: self.parse(self.products('shoes')).sample['image']['url']
      }

    elsif style[:type] == 'outerwear'

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: style[:outerwear_url],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: self.parse(self.products('pants')).sample['image']['url'],
        shoes: self.parse(self.products('shoes')).sample['image']['url']
      }

    elsif style[:type] == 'tops'

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: style[:tops_url],
        pants: self.parse(self.products('pants')).sample['image']['url'],
        shoes: self.parse(self.products('shoes')).sample['image']['url']
      }

    elsif style[:type] == 'pants'

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: style[:pants_url],
        shoes: self.parse(self.products('shoes')).sample['image']['url']
      }

    else

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: self.parse(self.products('pants')).sample['image']['url'],
        shoes: style[:shoes_url],
      }

    end
  end

  def self.swap(item, urls) 
    old_url = urls[item]
    until urls[item] != old_url 
      urls[item] = self.parse(self.products(item.to_s)).sample['image']['url']
    end 

    urls
  end 





end
