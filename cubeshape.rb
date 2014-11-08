require 'cuba'

Cuba.define do
  on get do
    on 'ohai' do
      res.write 'O HAI'
    end

    on root do
      res.redirect '/ohai'
    end
  end
end
