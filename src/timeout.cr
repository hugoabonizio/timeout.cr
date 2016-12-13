require "./timeout/*"

class Timeout
  def self.after_select_action(seconds)
    ch = Channel(Nil).new
    spawn do
      sleep seconds
      ch.send nil
    end
    ch.receive_select_action
  end

  def self.after(seconds, &block)
    Timeout.new(seconds, &block)
  end

  def initialize(seconds, &block)
    @canceled = false
    spawn do
      sleep seconds
      block.call unless @canceled
    end
  end

  def cancel
    @canceled = true
  end
end
