require 'shopsense'

class ApiInterface < ApplicationRecord

  @@client = Shopsense::API.new({'partner_id' => 'uid401-39901049-24'})

  def self.ten_products(type, offset=0, results=10)
    if type == "pants" || type == "pants jeans"
      type = "pants jeans"
      offset += 3100
    elsif type == "outerwear"
      offset += 0
    elsif type == "accessories"
      offset += 150
    elsif type == "shoes" || type == "heels"
      type = "heels"
      offset += 100
    else #tops
      offset += 150
    end

    response = @@client.search(type, offset, results)
    raw_products = JSON.parse(response)['products']
  end

  def self.products(type, offset=0, results=50)
    if type == "pants" || type == "pants jeans"
      type = "pants jeans"
      offset += 3100
    elsif type == "outerwear"
      offset += 0
    elsif type == "accessories"
      offset += 150
    elsif type == "shoes" || type == "heels"
      type = "heels"
      offset += 100
    else #tops
      offset += 150
    end

    response = @@client.search(type, offset, results)
    raw_products = JSON.parse(response)['products']
  end

  def self.parse(response)
    response.map do |product|
      image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
      if product["colors"] && product["colors"].is_a?(Array) && product["colors"].first 
        if product["colors"].first["canonical"]
          if product["name"] == "Relaxed Cross-Strap Tunic for Women"
            color = 'purple'
          else
            color = product["colors"].first["canonical"].first
          end
        elsif product["colors"].first["name"] && product["colors"].first["name"] == "Vintage Malibu Wash"
          color = "denim"
        end
      end
      puts product.inspect
      {
        'name' => product["name"],
        'image' => image,
        'color' => color ? color.downcase : "none"
      }
    end
  end

  def self.image_urls(style, color)
    if style[:type] == 'accessories'
      self.select_outfit_from_accessories(style, color)

    elsif style[:type] == 'outerwear'
      self.select_outfit_from_outerwear(style, color)
      
    elsif style[:type] == 'tops'
      self.select_outfit_from_tops(style, color)

    elsif style[:type] == 'pants'
      self.select_outfit_from_pants(style, color)

    else #shoes
      self.select_outfit_from_shoes(style, color)
    end
  end

  def self.swap(item, urls)
    old_url = urls[item]
    until urls[item] != old_url

      if item == "pants"
        urls[item] = self.parse(self.products('pants jeans')).sample['image']['url']
      elsif item == "shoes"
        urls[item] = self.parse(self.products('heels')).sample['image']['url']
      else 
        urls[item] = self.parse(self.products(item.to_s)).sample['image']['url']
      end 

    end

    urls
  end


######################################################################################################
##################### SELECTING STYLES BASED ON USER CHOICE###########################################
######################################################################################################


################################  PANTS  ########################################################

  def self.select_outfit_from_pants(style, color)
    if color == "tan" || color == "brown" || color == "beige"

      {
        accessories: self.parse(self.products('accessories')).select do |product|
          product["color"] == "black" ||
          product["color"] == "blue" ||
          product["color"] == "brown"
        end.sample["image"]["url"],

        outerwear: self.parse(self.products('outerwear')).select do |product|
          product["color"] == "black" ||
          product["color"] == "blue"
        end.sample["image"]["url"],

        tops: self.parse(self.products('tops')).select do |product|
          product["color"] == "denim" ||
          product["color"] == "black" ||
          product["color"] == "blue" ||
          product["color"] == "white" ||
          product["color"] == "green"
        end.sample["image"]["url"],

        pants: style[:pants_url],

        shoes: self.parse(self.products('heels')).select do |product|
          product["color"] == "black"
        end.sample["image"]["url"]
      } 

    elsif color == "blue" || color == "pink" || color == "green" || color == "red"

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],

        outerwear: self.parse(self.products('outerwear')).select do |product|
          product["color"] == "neutral" ||
          product["color"] == "sand" ||
          product["color"] == "black" ||
          product["color"] == "beige"
        end.sample["image"]["url"],

        tops: self.parse(self.products('tops')).select do |product|
          product["color"] == "black" ||
          product["color"] == "grey" ||
          product["color"] == "white" ||
          product["color"] == "gray"
        end.sample["image"]["url"],

        pants: style[:pants_url],

        shoes: self.parse(self.products('heels')).select do |product|
          product["color"] == "black" ||
          product["color"] == "nude" ||
          product["color"] == "tan" ||
          product["color"] == "gold" 
        end.sample["image"]["url"]
      } 

    elsif color == "white"

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],

        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],

        tops: self.parse(self.products('tops')).select do |product|
          product["color"] == "denim" ||
          product["color"] == "black" ||
          product["color"] == "white" 
        end.sample["image"]["url"],

        pants: style[:pants_url],

        shoes: self.parse(self.products('heels')).select do |product|
          product["color"] == "pink" ||
          product["color"] == "beige" ||
          product["color"] == "orange" ||
          product["color"] == "silver" ||
          product["color"] == "gold" 
        end.sample["image"]["url"]
      } 

    else

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: style[:pants_url],
        shoes: self.parse(self.products('heels')).sample['image']['url']
      }

    end
  end

################################  TOPS  ########################################################

  def self.select_outfit_from_tops(style, color)
    if false
    else 

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: style[:tops_url],
        pants: self.parse(self.products('pants jeans')).sample['image']['url'],
        shoes: self.parse(self.products('heels')).sample['image']['url']
      }

    end
  end

##################################  SHOES ########################################################

  def self.select_outfit_from_shoes(style, color)
    if false
    else 

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: self.parse(self.products('pants jeans')).sample['image']['url'],
        shoes: style[:shoes_url]
      }

    end
  end

################################  OUTERWEAR  ########################################################

  def self.select_outfit_from_outerwear(style, color)
    if false
    else 

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: style[:outerwear_url],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: self.parse(self.products('pants jeans')).sample['image']['url'],
        shoes: self.parse(self.products('heels')).sample['image']['url']
      }

    end
  end

##################################  ACCESSORIES  ##############################################

  def self.select_outfit_from_accessories(style, color)
    if false
    else 

      {
        accessories: style[:accessories_url],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: self.parse(self.products('pants jeans')).sample['image']['url'],
        shoes: self.parse(self.products('heels')).sample['image']['url']
      }

    end
  end

end
