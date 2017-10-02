class OutfitsController < ApplicationController

  def index
    @outfits = Outfit.all.select{|outfit| outfit.user_id == current_user.id}
  end 

  def show
    @outfit = Outfit.find(params[:id])
  end 

  def new
    @images = params[:images]
  end 

  def create
    images = params[:images]
    @outfit = Outfit.create({
      name: params[:name],
      user_id: current_user.id
      accessories_url: images[:accessories],
      outerwear_url: images[:outerwear], 
      tops_url: images[:tops], 
      bottoms_url: images[:bottoms], 
      shoes_url: images[:shoes]
    })
    redirect_to @outfit 
  end 

  def destroy 

  end 

end
