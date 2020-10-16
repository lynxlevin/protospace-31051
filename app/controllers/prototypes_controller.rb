class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC")
  end

  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = Prototype.new(proto_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new      
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(proto_params)
      redirect_to prototype_path
    else
      @prototype = Prototype.find(params[:id])
      @prototype.title = params[:prototype][:title]
      @prototype.catch_copy = params[:prototype][:catch_copy]
      @prototype.concept = params[:prototype][:concept]
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def proto_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
