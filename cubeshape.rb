require 'cuba'
require_relative 'painter'

Cuba.use Rack::ContentType, 'image/png'

Cuba.define do
  on get do
    on 'cubeshape/:shape' do |shape|
      size = req.params['size'] || 200
      colors = req.params['colors'].to_s.scan(/[a-z]/)
      rotate = req.params['rotate'].to_i
      res.headers['Content-Type']  = 'image/png'
      res.write Painter.new(size.to_i).shape_blob shape,
                                                  colors: colors,
                                                  rotate: rotate
    end

    on root do
      res.redirect '/cubeshape/cececece'
    end
  end
end
