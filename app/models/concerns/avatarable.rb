module Avatarable
  extend ActiveSupport::Concern

  def cropped_avatar
    avatar.variant(resize: "100x100^", gravity: "center", extent: '100x100')
  end
end
