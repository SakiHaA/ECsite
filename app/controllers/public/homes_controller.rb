class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(create_at: :desc).limit(4)
    @genres = Genre.all
  end
end
