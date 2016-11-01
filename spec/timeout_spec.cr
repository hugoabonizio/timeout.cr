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
end
