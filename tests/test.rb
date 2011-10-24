
require 'rubygems'
require 'vagrant'

env = Vagrant::Environment.new
env.vms.values.each do |vm|
   if vm.created?
	if vm.vm.running?
	  puts "is running"
          vm.ssh.execute do | ssh| 
		puts ssh.exec!("pt-query-digest /vagrant/tests/slow.log  --execute='h=localhost,u=jenkins,p=jenkins' | grep 'Exec time' | awk 'NR >1 { print $5 }' >/vagrant/tests/results.new")
	  end
        end
   end
end


