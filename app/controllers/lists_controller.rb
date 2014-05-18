class ListsController < ApplicationController
  def index
    @lists = List.all
    render
  end

  def show
    @list = List.find(params[:id])
    render
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    head status: :no_content
  end

  def create
    list = List.new(list_param)
    if list.save
      render list, status: :created
    else
      render json: { error: list.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_param)
      render @list
    else
      render json: {message:"Can't update this list."}, status: :bad_request
    end
  end

  private
  def list_param
    params.required(:list).permit(:position, :name)
  end
end