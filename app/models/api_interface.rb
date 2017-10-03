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

  def self.products(type)
    response = @@client.search(type, 0, 50)
    raw_products = JSON.parse(response)['products']
  end

  def self.parse(response)
    response.map do |product|
      image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
      if product["colors"] && product["colors"].is_a?(Array) && product["colors"].first && product["colors"].first["canonical"]
        color = product["colors"].first["canonical"].first
      end
      puts image.inspect
      {
        'name' => product["name"],
        'image' => image,
        'color' => color || "black"
      }
    end
  end

  def self.image_urls(style, color)
    if style[:type] == 'accessories'

      {
        accessories: style[:accessories_url],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: self.parse(self.products('pants jeans')).sample['image']['url'],
        shoes: self.parse(self.products('heels')).sample['image']['url']
      }

    elsif style[:type] == 'outerwear'

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: style[:outerwear_url],
        tops: self.parse(self.products('tops')).sample['image']['url'],
        pants: self.parse(self.products('pants jeans')).sample['image']['url'],
        shoes: self.parse(self.products('heels')).sample['image']['url']
      }

    elsif style[:type] == 'tops'

      {
        accessories: self.parse(self.products('accessories')).sample['image']['url'],
        outerwear: self.parse(self.products('outerwear')).sample['image']['url'],
        tops: style[:tops_url],
        pants: self.parse(self.products('pants jeans')).sample['image']['url'],
        shoes: self.parse(self.products('heels')).sample['image']['url']
      }

    elsif style[:type] == 'pants'
      self.select_outfit_from_pants(style, color)

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

  def self.swap(item, urls)
    old_url = urls[item]
    until urls[item] != old_url
      urls[item] = self.parse(self.products(item.to_s)).sample['image']['url']
    end

    urls
  end

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

  def self.select_outfit_from_tops(color)
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
    end
  end

  def self.select_outfit_from_shoes(color)
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
    end
  end

  def self.select_outfit_from_outerwear(color)
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
    end
  end

  def self.select_outfit_from_accessories(color)
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
    end
  end





  def self.fifty_tops
    response = self.products("tops")
    self.parse(response)
  end





end
