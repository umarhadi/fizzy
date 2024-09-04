module BubblesHelper
  BUBBLE_ROTATION = %w[ 90 80 75 60 45 35 25 5 -45 -40 -75 ]
  BUBBLE_SIZE = [ 14, 16, 18, 20, 22 ]
  MIN_THRESHOLD = 7

  def bubble_rotation(bubble)
    BUBBLE_ROTATION[Zlib.crc32(bubble.to_param) % BUBBLE_ROTATION.size]
  end

  def bubble_size(bubble)
    "--bubble-size: #{ BUBBLE_SIZE.min_by { |size| (size - (bubble.boosts.size + bubble.comments.size + MIN_THRESHOLD)).abs } }cqi;"
  end
end
