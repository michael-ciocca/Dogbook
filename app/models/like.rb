# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :dog
  belongs_to :user
end
