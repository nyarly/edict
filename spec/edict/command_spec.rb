require 'edict/command'

describe Edict::Command do

  let :mock_shell do
    instance_double(Caliph::Shell)
  end

  let :test_line do
    %w[a test command]
  end

  let :command_line do
    instance_double(Caliph::CommandLine)
  end

  let :result do
    instance_double(Caliph::CommandRunResult)
  end

  subject :command do
    Edict::Command.new do |test|
      test.env_hash = {:something => :else}
      test.command = test_line
      test.caliph_shell = mock_shell
    end
  end

  it "should run the command and check output" do
    allow(command).to receive(:cmd).with(*test_line).and_return(command_line)
    expect(command_line).to receive(:set_env).with(:something, :else)
    allow(mock_shell).to receive(:run).with(command_line).and_return(result)
    expect(result).to receive(:must_succeed!)

    command.enact
  end
end
