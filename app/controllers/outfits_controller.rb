class OutfitsController < ApplicationController

  def index
    @outfits = Outfit.all.select{|outfit| outfit.user_id == current_user.id}
  end

  def show
    @outfit = Outfit.find(params[:id])
  end

  def new
    @images = outfit_params
  end

  def create
    images = outfit_params
    @outfit = Outfit.create(
      name: params[:name],
      user_id: current_user.id,
      accessories_url: outfit_params[:accessories],
      outerwear_url: outfit_params[:outerwear],
      tops_url: outfit_params[:tops],
      pants_url: outfit_params[:pants],
      shoes_url: outfit_params[:shoes],
      description: outfit_params[:description]
    )
    redirect_to @outfit
  end

  def destroy
    outfit = Outfit.find(params[:id])
    outfit.destroy
    redirect_to outfits_path
  end

  private

  def outfit_params
    params.require(:images).permit(:accessories, :outerwear, :tops, :pants, :shoes, :description)
  end

end
