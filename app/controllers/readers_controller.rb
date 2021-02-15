class ReadersController < ApplicationController
  before_action :set_reader, only: [ :show, :edit, :update, :destroy]
  before_action :authenticate_admin! 

  def index
   
       @readers = Reader.all.order('created_at DESC').page(params[:page]).per_page(5)
      
 end

  # GET /texts/1 or /texts/1.json
  def show
    @reader = Reader.find(params[:id])
 end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_reader
      @reader = Reader.find(params[:id])
     end
end
