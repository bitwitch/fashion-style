class OutfitsController < ApplicationController

  def index
    @outfits = Outfit.all.select{|outfit| outfit.user_id == current_user.id}
  end

  def all_outfits
    user = User.find(params[:user_id].to_i)
    @outfits = Outfit.all.select{|outfit| outfit.user_id == user.id}
    render :index
  end

  def like_outfit
    @outfit = Outfit.find(params[:outfit_id].to_i)
    Like.create(user_id: current_user.id, outfit_id: @outfit.id)
    render :show
  end

  def view_likes
    outfit = Outfit.find(params[:outfit_id].to_i)
    @users = outfit.likes.map(&:user)
  end

  def outfits_i_like
    @outfits = current_user.likes.map(&:outfit)
    render :index
  end

  def unlike
    @outfit = Outfit.find(params[:outfit_id].to_i)
    like = current_user.likes.find { |like| like.outfit_id == @outfit.id }
    like.destroy
    render :show
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
      shoes_url: outfit_params[:shoes]
    )
    redirect_to @outfit
  end

  def destroy

  end

  private

  def outfit_params
    params.require(:images).permit(:accessories, :outerwear, :tops, :pants, :shoes)
  end

end
