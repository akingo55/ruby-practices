#!/usr/bin/env ruby

# obtain the path of current directory
current_dir = Dir.pwd

def get_files_and_dirs(current_dir)
  list = []
  Dir.open(current_dir).each_child{|f|
    unless f.start_with?('.')
      list << f
    end
  }
  return list
end

#number_of_elements = list.size

# 複数行に分けて標準出力する
def format_list(list)
  number_of_elements = list.size
  max_row = 3
  if number_of_elements <= max_row
    puts list.join("\t")
  else
    max_line = number_of_elements / max_row
  end

end

list = get_files_and_dirs(current_dir)
format_list(list)

