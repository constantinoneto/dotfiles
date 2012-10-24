require 'rubygems'
require 'interactive_editor'
require 'irb/completion'
require 'irb/ext/save-history'
require 'looksee/shortcuts'

%w|rubygems wirble hirb|.each do|lib|
  begin
    require lib
  rescue LoadError => err
    warn "Couldn't load an irb gem: #{err}"
  end
end


# IRB Options
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 100

# wirble (colors)
 Wirble.init
 Wirble.colorize

# hirb (active record)
 Hirb::View.enable

# awesome_print configuration
require 'ap'
=begin
IRB::Irb.class_eval do
  def output_value
    ap @context.last_value
  end
end
=end

# rails ------------------------------------------------------------------------

if defined?(Rails)

  def change_log(stream)
    ActiveRecord::Base.logger = Logger.new(stream)
    ActiveRecord::Base.clear_active_connections!
  end

  def show_log
    change_log(STDOUT)
  end

  def hide_log
    change_log(nil)
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end

  def sql(query)
    ActiveRecord::Base.sql(query)
  end

  class ActiveRecord::Base
    alias :attr :update_attribute
    def self.recent(n=10)
      limit(n).order('id desc')
    end
    def self.sql(query)
      self.connection.select_all(query)
    end
  end
end













