class ApiInterfaceController < ApplicationController

  def outerwear
    response  = ApiInterface.ten_products('outerwear')
    @products = ApiInterface.parse(response)
  end

  def tops
    response  = ApiInterface.ten_products('tops')
    @products = ApiInterface.parse(response)
  end

  def pants
    response  = ApiInterface.ten_products('pants')
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

  def style
    style   = params[:style]
    @images = ApiInterface.image_urls(style)
  end

  def swap_accessories
    images = image_params
    @images = ApiInterface.swap(:accessories, images)
    render :style
  end

  def swap_outerwear
    images = image_params
    @images = ApiInterface.swap(:outerwear, images)
    render :style
  end

  def swap_tops
    images = image_params
    @images = ApiInterface.swap(:tops, images)
    render :style
  end

  def swap_pants
    images = image_params
    @images = ApiInterface.swap(:pants, images)
    render :style
  end

  def swap_shoes
    images = image_params.to_h
    @images = ApiInterface.swap(:shoes, images)
    render :style
  end

  private 

  def image_params
    params.require(:images).permit(:accessories, :outerwear, :tops, :pants, :shoes)
  end 

end