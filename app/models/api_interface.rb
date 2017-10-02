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

      [
        {accessory: style[:accessories_url]},
        {outerwear: self.parse(self.products('outerwear')).sample['image']['url']},
        {top: self.parse(self.products('tops')).sample['image']['url']},
        {bottoms: self.parse(self.products('bottoms')).sample['image']['url']},
        {shoes: self.parse(self.products('shoes')).sample['image']['url']}
      ]

    elsif style[:type] == 'outerwear'

      [
        {accessory: self.parse(self.products('accessories').sample['image']['url']},
        {outerwear: style[:outerwear_url]},
        {top: self.parse(self.products('tops')).sample['image']['url']},
        {bottoms: self.parse(self.products('bottoms').sample['image']['url']},
        {shoes: self.parse(self.products('shoes').sample['image']['url']}
      ]

    elsif style[:type] == 'tops'

      [
        {accessory: self.parse(self.products('accessories').sample['image']['url']},
        {outerwear: self.parse(self.products('outerwear')).sample['image']['url']},
        {top: style[:tops_url]},
        {bottoms: self.parse(self.products('bottoms').sample['image']['url']},
        {shoes: self.parse(self.products('shoes').sample['image']['url']}
      ]

    elsif style[:type] == 'bottoms'

      [
        {accessory: self.parse(self.products('accessories').sample['image']['url']},
        {outerwear: self.parse(self.products('outerwear')).sample['image']['url']},
        {top: self.parse(self.products('tops')).sample['image']['url']},
        {bottoms: style[:bottoms_url]},
        {shoes: self.parse(self.products('shoes').sample['image']['url']}
      ]

    else

      [
        {accessory: self.parse(self.products('accessories').sample['image']['url']},
        {outerwear: self.parse(self.products('outerwear')).sample['image']['url']},
        {top: self.parse(self.products('tops')).sample['image']['url']},
        {bottoms: self.parse(self.products('bottoms').sample['image']['url']},
        {shoes: style[:shoes_url]},
      ]

    end
  end






end
