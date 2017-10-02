class ApiInterfaceController < ApplicationController

  def outerwear
    response  = ApiInterface.ten_outerwear
    @products = ApiInterface.parse(response)
  end

  def tops

  end

  def bottoms

  end

  def accessories

  end

  def shoes

  end

  def outfit 
    style   = params[:style]
    @images = ApiInterface.image_urls(style)
  end 

end
