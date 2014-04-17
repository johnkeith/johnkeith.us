# unable to test at school due to some uninstallable gems

module Jekyll
  class ExpertiseTag < Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      @format = markup.to_s
      @my_expertise = context.registers[:site].config['my_expertise']
      @expertise_formatted = []
    end

    # somewhat sanitize input from the _config.yml array
    def format_expertise
      @expertise_formatted = @my_expertise.map { |item| item.gsub(/\s/, "-") }.
                              map { |item| item.insert (0,"icon-") unless item.include?("icon-")}
    end

    def render(context)
      mfizz_icons = %w( icon-microscope icon-cplusplus icon-wireless icon-fire-alt 
                        icon-mobile-device icon-objc icon-redhat icon-freebsd icon-heroku 
                        icon-python icon-java icon-satellite icon-debian icon-grails 
                        icon-c icon-postgres icon-database-alt2 icon-raspberrypi icon-nginx 
                        icon-ruby-on-rails icon-redis icon-scala icon-gnome icon-perl 
                        icon-mysql icon-fedora icon-ghost icon-google icon-netbsd icon-aws 
                        icon-bomb icon-looking icon-ruby icon-mysql-alt icon-playframework-alt 
                        icon-osx icon-database icon-database-alt icon-shell icon-script 
                        icon-antenna icon-coffee-bean icon-scala-alt icon-platter icon-java-duke 
                        icon-iphone icon-script-alt icon-google-alt icon-haskell icon-mariadb 
                        icon-phone-retro icon-phone-alt icon-csharp icon-php icon-postgres-alt 
                        icon-html icon-mfizz icon-apache icon-hadoop icon-ruby-on-rails-alt 
                        icon-mobile-phone-broadcast icon-css icon-playframework icon-clojure 
                        icon-mobile-phone-alt icon-suse icon-java-bold icon-nginx-alt 
                        icon-nginx-alt2 icon-linux-mint icon-dreamhost icon-blackberry 
                        icon-javascript icon-ubuntu icon-php-alt icon-centos icon-nodejs 
                        icon-splatter icon-3dprint icon-line-graph icon-cassandra icon-solaris 
                        icon-jetty icon-tomcat icon-oracle icon-oracle-alt icon-mssql 
                        icon-google-developers icon-google-code icon-kde icon-grails-alt )

      html = ""
      
# two format possibilities - list view and inline layout (also known as plain)     

      if @format.match(/list/)
        html << "<div class='expertise-list'><ul class='mfizz-icons-descriptions'>"
        
        @expertise_formatted.each_with_index do |item_formatted, index|
          html << "<li><i class='mfizz-icons #{item_formatted}'></i> #{@my_expertise[index]}</li>" if mfizz_icons.include?(item_formatted)
        end

        html << "</ul></div>"
      else
        @expertise_formatted.each do |item_formatted|
          html << "<i class='mfizz-icons #{item_formatted}'></i>" if mfizz_icons.include?(item_formatted)
        end
      end
      html
    end
  end
end

# date_format = self.site.config['date_format']

# register the "expertise" tag
Liquid::Template.register_tag('expertise', Jekyll::ExpertiseTag)
