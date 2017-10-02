class ApiInterfaceController < ApplicationController

  def outerwear
    response  = ApiInterface.ten_products('outerwear')
    @products = ApiInterface.parse(response)
  end

  def tops
    response  = ApiInterface.ten_products('tops')
    @products = ApiInterface.parse(response)
  end

  def bottoms
    response  = ApiInterface.ten_products('bottoms')
    @products = ApiInterface.parse(response)
  end

  def accessories
    response  = ApiInterface.ten_products('accessories')
    @products = ApiInterface.parse(response)
  end

  def shoes
    response  = ApiInterface.ten_products('shoes')
    @products = ApiInterface.parse(response)
  end

  def outfit
    style   = params[:style]
    @images = ApiInterface.image_urls(style)
  end

  def swap_accessory
    render :outfit
  end

  def swap_outerwear
    render :outfit
  end

  def swap_top
    render :outfit
  end

  def swap_bottoms
    render :outfit
  end

  def swap_shoes
    render :outfit
  end

end
