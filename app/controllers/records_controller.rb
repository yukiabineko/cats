class RecordsController < ApplicationController
  
  def show
    @cats =current_user.cats.all if current_user.present?
  end
end
