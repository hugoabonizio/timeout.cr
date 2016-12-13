require "./spec_helper"

describe Timeout do
  it "should timeout after 1 second" do
    control = 0
    ch = Channel(Int32).new
    spawn do
      sleep 2
      ch.send 1
    end
    select
    when ch.receive
      control = 1
    when Timeout.after(1.second)
      control = 2
    end
    control.should eq 2
  end

  it "should execute a block after timeout" do
    flag = false
    timeout = Timeout.after(1.second) { flag = true }
    flag.should eq false
    sleep 1.5
    flag.should eq true
  end

  it "should cancel a timeout" do
    value = 0
    timeout = Timeout.after(1.second) { value += 1 }
    timeout.cancel
    sleep 2
    value.should eq 0
  end
end
