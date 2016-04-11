class BirdsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_bird, only: [:show, :edit, :update, :destroy]

  # POST /birds
  # POST /birds.json
  # Add new bird in data Sanctuary
  def create
    @bird = Bird.new(bird_params)
    if @bird.save
      render json: @bird, status: :created
    else
      render json: @bird.errors, status: :unprocessable_entity
    end
  end


  # GET /birds
  # GET /birds.json
  # Returns all the available birds in sanctuary
  def total_visible_birds
    @birds = Bird.all(visible: true)
    render json: @birds, status: :ok
  end


  # GET /birds/1
  # GET /birds/1.json
  # Return specific bird provided by bird id
  def bird_specification
    @bird = Bird.find(params[:id])
    if @bird
      @bird = JSON.parse(@bird.to_json)
      @bird["id"]=params[:id]
      render json: @bird.except("_id"), status: :ok
    else
      render :nothing => true, status: :not_found
    end
  end

  # DELETE /birds/1
  # DELETE /birds/1.json
  def remove
    @bird = Bird.find(params[:id])
    if @bird
      @bird.destroy
      render :nothing => true, status: :ok
    else
      render :nothing => true, status: :not_found
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def bird_params
    params.require(:name)
    params.require(:family)
    params.require(:continents)
    params.permit(:name, :family , :added, :visible, :continents => [])
  end
end
