require 'cuba'
require 'cuba/render'
require 'tilt/haml'
require_relative 'painter'

Cuba.plugin(Cuba::Render)
Cuba.settings[:render][:template_engine] = 'haml'


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
      res.write partial('cubeshape')
    end
  end
end
