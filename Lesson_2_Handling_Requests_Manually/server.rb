require 'socket' # requires the socket library

server = TCPServer.new('localhost', 3003)
# it's how 2 computers talk to each other. Through the TCP connection
# we're creating a server on local host with port 3003

loop do
  client = server.accept
  # waits until a request is sent, then accepts it

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  # we're getting the first line of whatever the request is
  puts request_line
  # print out that first line
  
  client.puts "HTTP/1.1 200/OK"
  client.puts request_line
  client.puts 

  # send that first line to the client so it prints out what they sent
  # this is the echo part basically
  client.close
  # close the connection with the client
end


