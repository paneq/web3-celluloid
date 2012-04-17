require 'celluloid'
require 'dcell'

ENV['PORT'] ||= '9234'
ENV['DCELL_PORT'] ||= (ENV['PORT'].to_i + 1).to_s
DCell.start :addr => "tcp://127.0.0.1:#{ENV['DCELL_PORT']}", :id => "id#{ENV['DCELL_PORT']}", :registry => {
    :adapter => 'redis',
    :host    => '127.0.0.1',
    :port    => 6379
  }

puts "started dcell"
10.times {
  Kernel.sleep(3)
  server = DCell::Global[:websockets]
  puts "sending notification"
  server.notify!("UserName", "notification from ruby")
}
puts "done sending"
