class Comment < ApplicationRecord
  belongs_to :bubble
  belongs_to :creator, class_name: "User", default: -> { Current.user }
end
