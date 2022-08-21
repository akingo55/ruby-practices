# frozen_string_literal: true

require 'etc'

TYPES = {
  'file' => '-',
  'directory' => 'd',
  'characterSpecial' => 'c',
  'blockSpecial' => 'b',
  'fifo' => 'p',
  'link' => 'l',
  'socket' => 's',
  'unknown' => '?'
}.freeze

PERMISSIONS = {
  7 => 'rwx',
  6 => 'rw-',
  5 => 'r-x',
  4 => 'r--',
  3 => '-wx',
  2 => '-w-',
  1 => '--x',
  0 => '---'
}.freeze

class File::Stat
  def details
    [
      converted_ftype + converted_permission,
      nlink,
      Etc.getpwuid(uid).name,
      Etc.getgrgid(gid).name,
      size,
      mtime.strftime('%m'),
      mtime.strftime('%d'),
      file? ? mtime.strftime('%H:%M') : mtime.strftime('%Y')
    ]
  end

  private

  def converted_ftype
    TYPES[ftype]
  end

  def converted_permission
    numbers = mode.to_s(8)[-3..].split('').map(&:to_i)
    numbers.map { |number| PERMISSIONS[number] }.join
  end
end
