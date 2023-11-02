class ListsController < ApplicationController
  def index
    @lists = List.texts
    @list_item = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      flash[:notice] = 'Task added successfully'
      redirect_to lists_path
      else
      render json: { success: false, errors: @list.errors.full_messages }, status: :bad_request
    end
  end

  private

  def list_params
    params.require(:list).permit(:text)
  end

end
