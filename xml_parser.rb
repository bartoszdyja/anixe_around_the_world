gem 'libxml-ruby', '>= 0.8.3'
require 'xml'
require 'socket'

class AroundWorldServer
  attr_reader :server, :respond
  def initialize(args = {})
    port = args[:port] || '3000'
    host = args[:host] || 'localhost'
    file = args[:file] || 'countries.xml'
    @server = TCPServer.open(host, port)
    io = File.open(file)
    parser = XML::Parser.io(io, encoding: XML::Encoding::ISO_8859_1)
    @respond = parser.parse
  end

  def start
    loop do
      Thread.start(server.accept) do |conn|
        code = conn.gets.split[1].delete('/').upcase
        result = respond.find_first("/countries/country[@COC='#{code}']")
        conn.puts result ? result.first : 'I don\'t understand'
        conn.close
      end
    end
  end
end

AroundWorldServer.new.start
