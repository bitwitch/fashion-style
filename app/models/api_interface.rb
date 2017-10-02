require 'shopsense'

class ApiInterface < ApplicationRecord

  @@client = Shopsense::API.new({'partner_id' => 'uid401-39901049-24'})

  def self.outerwear
    response = @@client.search('outerwear')
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





end
