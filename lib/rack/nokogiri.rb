require 'rack/nokogiri/version'

require 'rack'
require 'nokogiri'

module Rack
  class Nokogiri
    include Rack::Utils

    def initialize(app, opts = {}, &block)
      @app = app
      @opts = opts.select {|key, value| [:css, :xpath].include?(key) }
      @block = block
    end

    def call(env)
      status, headers, response = @app.call(env)
      headers = HeaderHash.new(headers)

      if should_process?(status, headers)
        content = extract_content(response)

        doc = ::Nokogiri::HTML(content)
        process_nodes(doc)
        content = doc.to_html

        headers['content-length'] = bytesize(content).to_s
        response = [content]
      end

      [status, headers, response]
    end

    def should_process?(status, headers)
      !STATUS_WITH_NO_ENTITY_BODY.include?(status) &&
         !headers['transfer-encoding'] &&
          headers['content-type'] &&
          headers['content-type'].include?('text/html')
    end

    def extract_content(response)
      response.reduce('') { |memo, part| memo + part }
    end

    def process_nodes(doc)
      nodes = ::Nokogiri::XML::NodeSet.new(doc)
      nodes += doc.css(@opts[:css])     unless @opts[:css].nil?
      nodes += doc.xpath(@opts[:xpath]) unless @opts[:xpath].nil?
      @block.call(nodes) unless nodes.empty?
    end

  end
end
