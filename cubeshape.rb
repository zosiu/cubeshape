require 'cuba'
require_relative 'painter'

Cuba.use Rack::ContentType, 'image/png'

Cuba.define do
  on get do
    on 'cubeshape/:shape' do |shape|
      size = req.params['size'] || 200
      colors = req.params['colors'].to_s.scan(/[a-z]/)
      res.headers['Content-Type']  = 'image/png'
      res.write Painter.new(size.to_i).shape_blob(shape, colors)
    end

    on root do
      res.redirect '/cubeshape/cececece'
    end
  end
end
