class TextsController < ApplicationController
  before_action :set_text, only: [ :show, :edit, :update, :destroy]
     
   #before_action :authenticate_reader! , except: [:index, :show, :edit]
    #before_action :authenticate_admin! , except: [ :index, :show, :edit, :update, :destroy]




  # GET /texts or /texts.json
  def index
     if reader_signed_in? 
        @texts = Text.where(reader_id: current_reader.id).order('created_at DESC').page(params[:page]).per_page(5)
        
     elsif admin_signed_in?
        @texts = Text.all.order('created_at DESC').page(params[:page]).per_page(5) 
     end
  end

  # GET /texts/1 or /texts/1.json
  def show
     @text = Text.find(params[:id])
  end

  # GET /texts/new
  def new
    @text = Text.new
  end

  # GET /texts/1/edit
  def edit
  end

  # POST /texts or /texts.json
  def create
    @text = Text.new(text_params)
    @text.reader_id = current_reader.id  
    @text.readability_index = @text.difficulty_method 
    @text.flesh_index = @text.rudolf_flesh_method
    #@text.speed_index = '1'
    respond_to do |format|
      if @text.save
        format.html { redirect_to @text, notice: "Text was successfully created." }
        format.json { render :show, status: :created, location: @text }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /texts/1 or /texts/1.json
  def update
    @text.readability_index = @text.difficulty_method
    @text.flesh_index = @text.rudolf_flesh_method
    #@text.speed_index = '15'

    respond_to do |format|
      if @text.update(text_params)
        format.html { redirect_to @text, notice: "Text was successfully updated." }
        format.json { render :show, status: :ok, location: @text }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1 or /texts/1.json
  def destroy
    @text = Text.find(params[:id])
    @text.destroy
    respond_to do |format|
      format.html { redirect_to texts_url, notice: "Text was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text
      if reader_signed_in? 
        @text = Text.where(reader_id: current_reader.id).find(params[:id])
        
     elsif admin_signed_in?
      @text = Text.find(params[:id])
     end

    
    end

    # Only allow a list of trusted parameters through.
    def text_params
      params.require(:text).permit(:description)
    end
end
