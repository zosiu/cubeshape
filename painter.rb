require 'rvg/rvg'

class Painter
  include Magick
  RVG::dpi = 72

  attr_reader :size

  def initialize(size_in_pixels)
    @size = size_in_pixels / RVG::dpi.to_f
  end

  def shape_vector(shape = 'cececece')
    rvg = RVG.new(size.in, size.in).viewbox(0, 0, 150, 150) do |canvas|
            # canvas.background_fill = 'white'
            rotate = 0.0
            shape.each_char do |char|
              case char
              when 'c'
                corner canvas, rotate
                rotate += 60.0
              when 'e'
                edge canvas, rotate
                rotate += 30.0
              end
            end
          end
    rvg.draw
  end

  def shape_blob(shape = 'cececece')
    vector = shape_vector(shape)
    vector.format = 'png'
    vector.to_blob
  end

  private

  def corner(canvas, rotate = 0)
    canvas.g.translate(canvas.width / 2.0, canvas.height / 2.0).rotate(rotate) do |c|
      a = 50
      b = 13.4
      c.polygon(0, 0, -b, a, -a, a, -a, b).styles(fill: 'orange')
      c.line(0, 0, -b, a)
      c.line(0, 0, -a, b)
    end
  end

  def edge(canvas, rotate = 0)
    a = 50
    b = 13.4
    canvas.g.translate(canvas.width / 2.0, canvas.height / 2.0).rotate(30 + rotate) do |c|
      c.polygon(0, 0, b, a, -b, a).styles(fill: 'red')
      c.line(0, 0, b, a)
      c.line(0, 0, -b, a)
    end
  end
end
