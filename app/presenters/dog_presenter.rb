# frozen_string_literal: true

class DogPresenter
  attr_reader :dog, :current_user

  def initialize(dog:, current_user:)
    @dog = dog
    @current_user = current_user
  end

  def like_button_text
    if already_liked?
      "Unlike this dog"
    else
      "Like this dog"
    end
  end

  private

  def already_liked?
    @already_liked ||= current_user&.liked_dogs&.include?(dog)
  end
end
