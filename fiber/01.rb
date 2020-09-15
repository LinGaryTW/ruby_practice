require 'socket'

server = TCPServer.new 3000

fibers = []
loop do
  begin
    client = server.accept_nonblock
    client.puts 'Hello World'

    fibers.each(&:resume)

    fiber = Fiber.new do
      buffer ||= ''
      begin
        buffer << client.read_nonblock(1024)
        if buffer.include?("\n")
          puts buffer
          client.close
        end
      rescue IO::WaitReadable
        puts 'RETRY'
        Fiber.yield
        retry
      end
    end

    fiber.resume
    fibers << fiber
  rescue IO::WaitReadable
    sleep 1
    retry
  end
end