# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :try_allow_like, only: [:toggle]

  def toggle
    respond_to do |format|
      if handle_like
        format.html { redirect_to @dog }
        format.json { head :no_content }
      else
        format.html { redirect_to @dog, notice: "Failed to like dog" }
        format.json { head :unprocessable_entity }
      end
    end
  end

  private

  def try_allow_like
    if current_user == dog.owner
      flash[:notice] = "Cannot like your own dog"
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.json { head :forbidden }
      end
    end
  end

  def handle_like
    like = Like.find_or_initialize_by(user: current_user, dog: @dog)

    if like.persisted?
      like.destroy
    else
      like.save
    end
  end

  def dog
    @dog ||= Dog.find(params[:dog_id])
  end
end
