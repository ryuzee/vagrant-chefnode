# -*- encoding: utf-8 -*-
# vim: set fileencoding=utf-8

require "vagrant"
require "vagrant-chefnode/command"

module VagrantChefnode
  class Plugin < Vagrant.plugin("2")
    name "Chefnode"
    description <<-DESC
    Remove nodes and clients from Chef Server
    DESC

    action_hook(self::ALL_ACTIONS) do |hook|
      hook.after(VagrantPlugins::ProviderVirtualBox::Action::Destroy, VagrantChefnode::Command)
    end

  end
end
