class ApiInterfaceController < ApplicationController

  def outerwear
    response = ApiInterface.outerwear
    byebug
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

end
