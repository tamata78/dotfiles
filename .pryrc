# display version
Pry.config.prompt = proc do |obj, nest_level, _pry_|
version = ''
version << "#{RUBY_VERSION}"

"#{version} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})> "
end

# change color
def Pry.set_color sym, color
  CodeRay::Encoders::Terminal::TOKEN_COLORS[sym] = color.to_s
  { sym => color.to_s }
end

Pry.set_color :integer, "\e[1;32m"

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'

