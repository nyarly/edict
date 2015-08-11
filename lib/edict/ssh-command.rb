
begin
  require 'caliph'
  require 'edict/command'

  module Edict
    class SSHCommand < Command
      setting(:remote_server, nested{
        setting :address
        setting :port, 22
        setting :user, nil
      })

      setting(:ssh_options, [])
      setting(:verbose, 0)
      nil_fields(:id_file, :free_arguments)

      def ssh_option(name, value)
        ssh_options << "\"#{name}=#{value}\""
      end

      def wrap_ssh_around(command_on_remote)
        raise "Empty remote command" if command_on_remote.nil?
        cmd("ssh") do |cmd|
          cmd.options << "-i #{id_file}" if id_file
          cmd.options << "-l #{remote_server.user}" unless remote_server.user.nil?
          cmd.options << remote_server.address
          cmd.options << "-p #{remote_server.port}" #ok
          cmd.options << "-n"
          cmd.options << "-#{'v'*verbose}" if verbose > 0
          unless ssh_options.empty?
            ssh_options.each do |opt|
              cmd.options << "-o #{opt}"
            end
          end
          cmd - escaped_command(command_on_remote)
        end
      end

      def run_command(command)
        fail "Need remote server for #{self.class.name}" unless remote_server.address

        super(wrap_ssh_around(command))
      end
    end
  end
rescue LoadError
  # no Caliph...
end
