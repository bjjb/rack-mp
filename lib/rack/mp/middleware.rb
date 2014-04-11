require 'multi_json'

module Rack
  module MP
    # Small middleware to count Ruby objects before and after a request. Puts
    # the values in the X-MP-ObjectCounts response header. Just pass
    # __mp__=counts in the query string.
    #
    # That's all it does at the moment - probably only useful for identifying
    # which type of object is causing a memory leak. And, possibly, confirming
    # which queries are contributing.
    class Middleware

      # New middleware instance.
      def initialize(app)
        @app = app
      end

      # Run the middleware. Will count the objects, run the app, count the
      # objects, and output how long the whole thing took, and the number of
      # objects before and after.
      #
      # NOTE - the header string will be JSON! Yuck. But it was the quickest
      # way to do it for now.
      def call(env)
        return @app.call(env) unless active?(env)
        before, t0 = time { count_objects }
        result, t1 = time { @app.call(env.merge('mp.counting' => true)) }
        after,  t2 = time { count_objects }
        timings = { before: t0, request: t1, after: t2 }
        data = serialize(before: before, after: after, timings: timings)
        status, headers, body = *result
        [status, headers.merge('X-MP-ObjectCounts' => data), result]
      end

      private
      # Check whether we need to do anything.
      # Just looks for __mp__=counts in the query string. Not very
      # sophisticated. Could be extended to check authentication, etc.
      def active?(env)
        env['QUERY_STRING'] =~ %r{__mp__=counts}
      end

      # The simplest object counter. Could potentially be expanded to ask all
      # apps in a cluster, and sum them!
      def count_objects
        ObjectSpace.count_objects
      end

      # Make a string for the response.
      # Easiest output for now seems to be JSON
      def serialize(*args)
        MultiJson.dump(*args)
      end

      # Time an operation, returning the operation's result and the time it
      # took.
      def time(&block)
        t = Time.now
        [yield, Time.now - t]
      end
    end
  end
end
