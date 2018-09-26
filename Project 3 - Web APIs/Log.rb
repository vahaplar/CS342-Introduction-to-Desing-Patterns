require 'singleton'

class Log
  include Singleton

  def initialize
    @fileHtml = File.new("gif.html", "w+")
  end

  def output(msg)
    puts msg
  end

  def writeHTML(msg)
    @fileHtml.puts "<html><body bgcolor='black'>"
    @fileHtml.puts "<iframe src=#{msg} "
    @fileHtml.puts "text-align=center width=100% vertical-align=middle height=480px display=table-cell allowFullScreen>"
    @fileHtml.puts"</iframe>"
    @fileHtml.puts "</body></html>"
    @fileHtml.close()
  end
end