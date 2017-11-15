module HellStock
  module Server
    module_function

    def run(port: 8081, controller_class:)
      EM.run do
        EM.start_server '0.0.0.0', port, controller_class
        yield if block_given?
      end
    end
  end
end
