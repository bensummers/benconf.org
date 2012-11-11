
require 'rubygems'
require 'mongrel'

class NoDotHTML < Mongrel::DirHandler
  def can_serve(path_info)
    path_info = path_info + '.html' unless path_info == '/' || path_info.include?('.')
    super(path_info)
  end
#  def send_file(req_path, request, response, header_only)
#    req_path = req_path + '.html' unless req_path == '/' || req_path.include?('.')
#    super(req_path, request, response, header_only)
#  end
end

h = Mongrel::HttpServer.new("0.0.0.0", "4500")
h.register("/", NoDotHTML.new("./root"))

puts "Point browser at http://127.0.0.1:4500"

h.run.join

