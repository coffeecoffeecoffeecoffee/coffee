module ColorHelper
  def random_color
    "hsva(#{rand(0..360)}, 60%, 90%, 0.4)".paint.to_rgb
  end
end
