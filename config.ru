class Hello
  def self.call(env)
    [ 200,                              # 200 indicates success
      {"Content-Type" => "text/plain"}, # the hash of headers
      ["Hello from Rack!"]              # we wrap the body in an Array so
                                        # that it responds to `each`
    ]
  end
end

# Tell Rack what to run our app
run Hello
