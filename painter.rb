require 'rvg/rvg'

class Painter
  include Magick
  RVG::dpi = 72

  attr_reader :size

  def initialize(size_in_pixels)
    @size = size_in_pixels / RVG::dpi.to_f
  end

  def shape_vector(shape = 'cececece', colors = [])
    no_stickers = colors.size <= shape.size
    rvg = RVG.new(size.in, size.in).viewbox(0, 0, 180, 180) do |canvas|
            rotate = 0.0
            shape.each_char do |char|
              case char
              when 'c'
                options = {}
                options[:rotate] = rotate
                options[:color] = color(colors.shift)
                options[:left_sticker_color] = color(colors.shift) unless no_stickers
                options[:right_sticker_color] = color(colors.shift) unless no_stickers
                corner canvas, options
                rotate += 60.0
              when 'e'
                options = {}
                options[:rotate] = rotate
                options[:color] = color(colors.shift)
                options[:sticker_color] = color(colors.shift) unless no_stickers

                edge canvas, options
                rotate += 30.0
              end
            end
          end
    rvg.draw
  end

  def shape_blob(shape = 'cececece', colors = [])
    vector = shape_vector(shape, colors)
    vector.format = 'png'
    vector.to_blob
  end

  private

  def color(char)
    case char
    when 'd' then 'darkgrey'
    when 'g' then 'green'
    when 'b' then 'blue'
    when 'y' then 'yellow'
    when 'r' then 'red'
    when 'w' then 'white'
    when 'o' then 'orange'
    else 'darkgrey'
    end
  end

  def self.magic_numbers
    { a: 50,
      b: 13.4,
      d: 63.4,
      e: 13,
      f: 10.6 }
  end

  magic_numbers.keys.each do |key|
    define_method key do
      Painter.magic_numbers[key]
    end
  end

  def corner(canvas, options = {})
    default_options = { rotate: 0, color: 'darkgrey' }
    options = default_options.merge options

    canvas.g.translate(canvas.width / 2.0, canvas.height / 2.0).rotate(options[:rotate]) do |c|
      # corner
      c.polygon(0, 0, -b, a, -a, a, -a, b).styles(fill: options[:color])

      # corner outline
      c.line(0, 0, -b, a)
      c.line(0, 0, -a, b)
      c.line(-b, a, -a, a)
      c.line(-a, b, -a, a)
    end

    corner_stickers(canvas, rotate: options[:rotate],
                            left_sticker_color: options[:left_sticker_color],
                            right_sticker_color: options[:right_sticker_color]) if options[:left_sticker_color] && options[:right_sticker_color]
  end

  def corner_stickers(canvas, options = {})
    default_options = { rotate: 0, left_sticker_color: 'darkgrey', right_sticker_color: 'darkgrey' }
    options = default_options.merge options

    canvas.g.translate(canvas.width / 2.0, canvas.height / 2.0).rotate(options[:rotate]) do |c|
      # left corner sticker
      c.polygon(-b+e, a, -a+e, a, -a+e, d, -b+e, d).styles(fill: options[:left_sticker_color]).skewX(-15)

      # right corner sticker
      c.polygon(-d, a-f, -d, b-f, -a, b-f, -a, a-f).styles(fill: options[:right_sticker_color]).skewY(24)
    end
  end

  def edge(canvas, options = {})
    default_options = { rotate: 0, color: 'darkgrey' }
    options = default_options.merge options

    canvas.g.translate(canvas.width / 2.0, canvas.height / 2.0).rotate(30 + options[:rotate]) do |c|
      # edge
      c.polygon(0, 0, b, a, -b, a).styles(fill: options[:color])

      # edge outline
      c.line(0, 0, b, a)
      c.line(0, 0, -b, a)
      c.line(b, a, -b, a)
    end

    edge_sticker(canvas, rotate: options[:rotate],
                         color: options[:sticker_color]) if options[:sticker_color]
  end

  def edge_sticker(canvas, options = {})
    default_options = { rotate: 0, color: 'darkgrey' }
    options = default_options.merge options

    canvas.g.translate(canvas.width / 2.0, canvas.height / 2.0).rotate(30 + options[:rotate]) do |c|
      # edge sticker
      c.polygon(b/360*15, a, -b, a, -b, d, b/360*15, d).styles(fill: options[:color]).skewX(15)
      c.polygon(b/360*15+e, a, e-b, a, e-b, d, b/360*15+e, d).styles(fill: options[:color]).skewX(-15)
      c.polygon(b, a, -b, a, -b, d, b, d).styles(fill: options[:color])
    end
  end
end
