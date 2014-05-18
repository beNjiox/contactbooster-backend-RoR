class ListsController < ApplicationController
  def index
    @lists = List.all
    render
  end

  def show
    @list = List.find(params[:id])
    render
  end
end