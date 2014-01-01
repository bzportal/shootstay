class PicturesController < ApplicationController
  before_filter :authenticate_user!

	# GET /pictures
  # GET /pictures.json
  def index
    house_id = params[:house_id]
    @pictures = Picture.where(house_id: house_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures.map{|picture| picture.to_jq_picture } }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    failed = false
    photos = params[:picture][:photo]
    
    photos.each do |photo|
      params[:picture][:photo] = photo
      @picture = Picture.new(params[:picture])
      
      failed = true unless @picture.save
    end
    
    respond_to do |format|
      if failed == false
        format.html {
          render :json => [@picture.to_jq_picture].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@picture.to_jq_picture]}, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
    end
  end
end
