require_relative '../../../../test/helper'
require_relative '../../../../lib/hell_stock/helper'
require_relative '../../../../lib/hell_stock/command/view'
require_relative '../../../../lib/hell_stock/command/system'


class TestView < Test::Unit::TestCase
  include HellStock::Command
  include HellStock::Helper

  def setup
    @view = View.new
  end

  def test_logo_path
    @view.logo_path = logo_path
    assert(@view.logo_path == logo_path, 'It shoud include logo file')
  end

  def test_quantity_of_file_in_stock
    p "Logo_path: #{logo_path}"
    number_of_file = Dir["#{logo_path}/**/*.txt"]
    assert(!number_of_file.size.zero?, 'It should include more than 1 logo')
  end

  private

  def logo_path
    root = File.dirname(__FILE__).sub('test/lib/hell_stock/command', '')
    folder_name = 'public/images/logo/'
    logo_path = File.join(root, folder_name)
    if logo_path[0] == '/'
      logo_path[1..-1]
    else
      logo_path
    end
  end
end
