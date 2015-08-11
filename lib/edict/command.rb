begin
  require 'caliph'
  require 'edict/rule'

  module Edict
    class Command < Rule
      include Caliph::CommandLineDSL

      setting :caliph_shell
      setting :env_hash, {}
      setting :command

      def self.shell
        @shell ||= Caliph.new
      end

      def setup
        self.caliph_shell = Edict::Command.shell if field_unset?(:caliph_shell)
      end

      def build_command
        cmd(*command)
      end

      def add_env(command)
        env_hash.each_pair do |name, value|
          command.set_env(name, value)
        end
        command
      end

      def run_command(command)
        caliph_shell.run(command)
      end

      def check_result(result)
        result.must_succeed!
      end

      def action
        to_run = build_command
        to_run = add_env(to_run)
        result = run_command(to_run)
        check_result(result)
      end
    end
  end
rescue LoadError
  # no-op - we don't have Caliph
end
