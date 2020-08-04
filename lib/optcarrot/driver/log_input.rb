module Optcarrot
  # Input driver replaying a recorded input log
  class LogInput < Input
    def init
      @log = @conf.key_log || []
      @log = RDL.type_cast(Marshal.load(File.binread(RDL.type_cast(@log, "String"))), "String") if @log.is_a?(String)
      @prev_state = 0
    end

    attr_writer :log

    def dispose
    end

    def tick(frame, pads)
      state = @log[frame] || 0
      [
        Pad::SELECT,
        Pad::START,
        Pad::A,
        Pad::B,
        Pad::RIGHT,
        Pad::LEFT,
        Pad::DOWN,
        Pad::UP,
      ].each do |i|
        if @prev_state[i] == 0 && state[i] == 1
          pads.keydown(0, i)
        elsif @prev_state[i] == 1 && state[i] == 0
          pads.keyup(0, i)
        end
      end
      @prev_state = state
    end
  end
end
