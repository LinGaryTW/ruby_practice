require 'socket'
require 'fiber'

class Selector
  def initialize
    @fibers = {}
  end

  def register(io)
    @fibers[io] = Fiber.current
    Fiber.yield
    @fibers.delete(io)
  end

  def resume
    readable, = IO.select(@fibers.keys)
    readable.each do |io|
      @fibers[io].resume
    end
    puts readable.to_s + 'aaaaa'
  end
end

selector = Selector.new
server = TCPServer.new 3000

Fiber.new do
  loop do
    client = server.accept_nonblock(exception: false)
    puts client.to_s + '====='
    selector.register(server) if client == :wait_readable
    next if client == :wait_readable

    Fiber.new do
      buffer ||= ''
      loop do
        read = client.read_nonblock(1024, exception: false)
        selector.register(client) if read == :wait_readable
        next if read == :wait_readable
        buffer << read
        puts buffer if buffer.include?("\n")
      end
    end.resume
  end
end.resume

loop do
  selector.resume
end