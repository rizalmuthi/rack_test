class ToUpper
  # Our class will be initialize with another Rack app
  def initialize(app)
    @app = app
  end

  def call(env)
    # First, call `@app`
    status, headers, body  = @app.call(env)

    # Iterate through the body, upcasing each chunk
    upcased_body = body.map { |chunk| chunk.upcase }

    # Pass our new body on through
    [status, headers, upcased_body]
  end
end

# This is the same Hello app from before, just without all the comments
# We can use the Request and Response Classes

class Hello
  def self.call(env)
    # [ 200, {"Content-Type" => "text/plain"}, ["Hello from Rack!"] ]

    res = Rack::Response.new

    # This will automatically set the Content-Length header for you
    res.write("Hello from Rack!")

    # returns the standard [status, headers, body] array
    res.finish

    # You can get/set headers with square bracket syntax:
    #   res["Content-Type"] = "text/plain"

    # You can set and delete cookies
    #   res.set_cookie("user_id", 1)
    #   res.delete_cookie("user_id")
  end
end

# use ToUpper # Tell Rack to use our newly-minted middleware
run Hello

# above code equal to:
# app = ToUpper.new(Hello)
# run app


# use Middleware1
# use Middleware2
# use Middleware3
# run MyApp

#=> Boils down to Middleware1.new(Middleware2.new(Middleware3.new(MyApp)))
