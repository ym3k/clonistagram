class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :set_login, only: [:new, :edit, :show, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id


    respond_to do |format|
      if @picture.save
        format.html { redirect_and_mail(@picture, "作成")  }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_and_mail(@picture, "編集") }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_and_mail( @picture, "削除") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end
    
    def redirect_and_mail(picture, action)
      @picture = picture
      @action = action
      PictureMailer.picture_mail(@picture, @action).deliver
      redirect_to pictures_path, notice: "ピクチャを" + @action + "しました！"
    end
  
    def set_login
      if !logged_in?
        redirect_to new_session_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:image, :comment)
    end
end
