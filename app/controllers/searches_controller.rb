class SearchesController < ApplicationController
  def index
    @rooms = Room.all

    # エリア検索
    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    # フリーワード検索
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", keyword, keyword)
    end

    @count = @rooms.count
  end
end
