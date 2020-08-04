#require '../type-infer/rdl/lib/rdl'
require 'rdl'
RDL::Config.instance.number_mode = true

require 'types/core'

require 'zlib'

require './lib/optcarrot'
#Dir['./lib/optcarrot/driver/*.rb'].each { |file| require file }
require './lib/optcarrot/driver/gif_video.rb'
require './lib/optcarrot/driver/log_input.rb'
require './lib/optcarrot/driver/misc.rb'
require './lib/optcarrot/driver/mplayer_video.rb'
#require './lib/optcarrot/driver/png_video.rb'
require './lib/optcarrot/driver/sdl2.rb'
require './lib/optcarrot/driver/sdl2_audio.rb'
require './lib/optcarrot/driver/sdl2_video.rb'
require './lib/optcarrot/driver/sdl2_input.rb'
#require './lib/optcarrot/driver/sfml.rb' # missing FFI libs
#require './lib/optcarrot/driver/sfml_audio.rb'
#require './lib/optcarrot/driver/sfml_input.rb'
#require './lib/optcarrot/driver/sfml_video.rb'
require './lib/optcarrot/driver/sixel_video.rb'
require './lib/optcarrot/driver/term_input.rb'
require './lib/optcarrot/driver/wav_audio.rb'

RDL.no_infer_meth Optcarrot::APU::Oscillator, :poke_2
RDL.no_infer_meth Optcarrot::APU::Oscillator, :poke_3
## POTENTIAL BUG: ... or maybe just occurence typing. update_freq only defined for subclasses, but guard is only true for subclasses.

#RDL.no_infer_meth Optcarrot::APU::Noise, :sample ## THESE THREE HAVE OVERLOADED, <= struct type issue
#RDL.no_infer_meth Optcarrot::APU::Pulse, :sample
#RDL.no_infer_meth Optcarrot::APU::Mixer, :sample
RDL.infer_file './lib/optcarrot/apu.rb'


RDL.infer_file './lib/optcarrot/config.rb'


RDL.no_infer_meth Optcarrot::CPU::OptimizedCodeBuilder, :build_loop ## POSSIBLE BUG: `code` on line 1124 might be a symbol, can't splat it.
RDL.infer_file './lib/optcarrot/cpu.rb'


#RDL.no_infer_meth Optcarrot::Video, :init # Integer or Float issue, can't determine where constraint is being generated
RDL.infer_file './lib/optcarrot/driver.rb'


RDL.no_infer_meth Optcarrot::NES, :initialize ## POSSIBLE BUG: Driver.load overrides Kernel.load, but has different type (causes a multiple assignment issue)
RDL.no_infer_meth Optcarrot::NES, :run ## POSSIBLE BUG: Undefined constant StackProf
RDL.infer_file './lib/optcarrot/nes.rb'


RDL.no_infer_meth Optcarrot::CodeOptimizationHelper, :initialize ## mixin
RDL.infer_file './lib/optcarrot/opt.rb'


RDL.infer_file './lib/optcarrot/pad.rb'

RDL.no_infer_meth Optcarrot::Palette, :nestopia_palette ## map with block with multiple arguments, not sure how to support
RDL.infer_file './lib/optcarrot/palette.rb'

RDL.no_infer_meth Optcarrot::PPU::OptimizedCodeBuilder, :build_loop ## same map issue as above
RDL.no_infer_meth Optcarrot::PPU, :setup_lut ## very complex data structures, can't figure out casts
#RDL.no_infer_meth Optcarrot::PPU, :poke_2007
RDL.infer_file './lib/optcarrot/ppu.rb'

RDL.infer_file './lib/optcarrot/rom.rb'

#RDL.infer_file './lib/optcarrot/driver/ao_audio.rb' ## requires FFI lib
RDL.infer_file './lib/optcarrot/driver/gif_video.rb'
RDL.infer_file './lib/optcarrot/driver/log_input.rb'

RDL.no_infer_meth Optcarrot::Driver, :quantize_colors ## inject block_pass issue
RDL.no_infer_meth Optcarrot::Driver, :icon_data ## FFI issue
RDL.infer_file './lib/optcarrot/driver/misc.rb'

RDL.infer_file './lib/optcarrot/driver/mplayer_video.rb'

#RDL.infer_file './lib/optcarrot/driver/png_video.rb' ## weird syntax error

RDL.infer_file './lib/optcarrot/driver/sdl2.rb'
RDL.infer_file './lib/optcarrot/driver/sdl2_audio.rb'
RDL.no_infer_meth Optcarrot::SDL2Input, :tick ## splat issue
RDL.infer_file './lib/optcarrot/driver/sdl2_input.rb'
RDL.infer_file './lib/optcarrot/driver/sdl2_video.rb'

#RDL.infer_file './lib/optcarrot/driver/sfml.rb' ## missing FFI libs
#RDL.infer_file './lib/optcarrot/driver/sfml_audio.rb'
#RDL.infer_file './lib/optcarrot/driver/sfml_input.rb'
#RDL.infer_file './lib/optcarrot/driver/sfml_video.rb'

RDL.infer_file './lib/optcarrot/driver/sixel_video.rb'
RDL.infer_file './lib/optcarrot/driver/term_input.rb'
RDL.infer_file './lib/optcarrot/driver/wav_audio.rb'

RDL.infer_file './lib/optcarrot/mapper/cnrom.rb'

RDL.no_infer_meth Optcarrot::MMC1, :update_chr ## non-terminating solution extraction, can't figure out why
RDL.infer_file './lib/optcarrot/mapper/mmc1.rb'
RDL.infer_file './lib/optcarrot/mapper/mmc3.rb'
RDL.infer_file './lib/optcarrot/mapper/uxrom.rb'

RDL.do_infer :files, num_times: 1


