# coding: utf-8
# vim: set fileencoding=utf-8

module VagrantChefnode
  class Command 

    def initialize(app, env)
      @app = app
      @env = env
    end

    def call(env)
      require 'chef'
      require 'chef/config'
      require 'chef/knife'
      config = File.expand_path("../../../../../../.chef/knife.rb", File.dirname(__FILE__))
      ::Chef::Config.from_file(config)

      chef_server_url = ::Chef::Config[:chef_server_url]
      defined_chef_server_url = ""
      env[:machine].config.vm.provision :chef_client do |chef|
        defined_chef_server_url = chef.chef_server_url
      end
      if chef_server_url == "" || defined_chef_server_url == "" || chef_server_url != defined_chef_server_url then
        @app.call(env)
        return
      end

      node = env[:machine].config.vm.hostname
      message = "Are you sure you want to remove node and client named '#{node}' from chef server ? [y/N] "
      choice = env[:ui].ask(message)
      if choice.upcase != "Y" then
        @app.call(env)
        return
      end

      ["client", "node"].each do |elm|
        env[:ui].info "Attempting to remove #{elm} '#{node}' from chef server."
        begin
          ::Chef::REST.new(chef_server_url).delete_rest("#{elm}s/#{node}")
        rescue Net::HTTPServerException => e
          if e.message == '404 "Not Found"'
            env[:ui].info "#{elm} '#{node}' not found."
          else
            env[:ui].error "An error occured. You will have to remove the #{elm} manually."
          end
        rescue Exception => e
            env[:ui].error "An error occured. You will have to remove the #{elm} manually."
        else
          env[:ui].info "#{elm} '#{node}' successfully removed from chef server."
        end
      end

      @app.call(env)
    end
  end
end
