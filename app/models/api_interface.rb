require 'shopsense'

class ApiInterface < ApplicationRecord

  @@client = Shopsense::API.new({'partner_id' => 'uid401-39901049-24'})


  def self.ten_accessories
    response = @@client.search('accessories')
    raw_products = JSON.parse(response)['products']
  end 

  def self.ten_outerwear
    response = @@client.search('outerwear')
    raw_products = JSON.parse(response)['products']
  end

  def self.ten_tops 
    response = @@client.search('tops')
    raw_products = JSON.parse(response)['products']
  end 

  def self.ten_bottoms
    response = @@client.search('pants')
    raw_products = JSON.parse(response)['products']
  end

  def self.ten_shoes
    response = @@client.search('shoes')
    raw_products = JSON.parse(response)['products']
  end

  def self.accessories
    response = @@client.search('accessories', 0, 50)
    raw_products = JSON.parse(response)['products']
  end 

  def self.outerwear
    response = @@client.search('outerwear', 0, 50)
    raw_products = JSON.parse(response)['products']
  end

  def self.tops 
    response = @@client.search('tops', 0, 50)
    raw_products = JSON.parse(response)['products']
  end 

  def self.bottoms
    response = @@client.search('pants', 0, 50 )
    raw_products = JSON.parse(response)['products']
  end

  def self.shoes
    response = @@client.search('shoes', 0, 50)
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
        style[:accessories_url],
        self.parse(self.accessories).sample['image']['url'],
        self.parse(self.tops).sample['image']['url'],
        self.parse(self.bottoms).sample['image']['url'],
        self.parse(self.shoes).sample['image']['url']
      ]

    elsif style[:type] == 'outerwear'

      [
        self.parse(self.accessories).sample['image']['url'],
        style[:outerwear_url],
        self.parse(self.tops).sample['image']['url'],
        self.parse(self.bottoms).sample['image']['url'],
        self.parse(self.shoes).sample['image']['url']
      ]

    elsif style[:type] == 'tops'

      [
        self.parse(self.accessories).sample['image']['url'],
        self.parse(self.outerwear).sample['image']['url'],
        style[:tops_url],
        self.parse(self.bottoms).sample['image']['url'],
        self.parse(self.shoes).sample['image']['url']
      ]

    elsif style[:type] == 'bottoms'

      [
        self.parse(self.accessories).sample['image']['url'],
        self.parse(self.outerwear).sample['image']['url'],
        self.parse(self.tops).sample['image']['url'],
        style[:bottoms_url],
        self.parse(self.shoes).sample['image']['url']
      ]

    else

      [
        self.parse(self.accessories).sample['image']['url'],
        self.parse(self.outerwear).sample['image']['url'],
        self.parse(self.tops).sample['image']['url'],
        self.parse(self.bottoms).sample['image']['url'],
        style[:shoes_url]
      ]

    end 
  end 





end
