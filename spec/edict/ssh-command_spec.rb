require 'edict'

describe Edict::SSHCommand do

  let :mock_shell do
    instance_double(Caliph::Shell)
  end

  let :test_line do
    %w[a test command]
  end

  let :command_line do
    instance_double(Caliph::CommandLine, "remote command")
  end

  let :ssh_command_line do
    instance_double(Caliph::CommandLine, "ssh command")
  end

  let :ssh_options do
    []
  end

  let :result do
    instance_double(Caliph::CommandRunResult)
  end

  let :server_address do
    "123.45.67.89"
  end

  subject :command do
    Edict::SSHCommand.new do |test|
      test.env_hash = {:something => :else}
      test.command = test_line
      test.caliph_shell = mock_shell
      test.remote_server.address = server_address
    end
  end

  it "should run the command and check output" do
    allow(command).to receive(:cmd).with(*test_line).and_return(command_line)
    allow(command).to receive(:cmd).with("ssh").and_yield(ssh_command_line).and_return(ssh_command_line)
    allow(ssh_command_line).to receive(:options).and_return(ssh_options)
    allow(command).to receive(:escaped_command).and_return(command_line)
    expect(ssh_command_line).to receive(:-).with(command_line)

    expect(command_line).to receive(:set_env).with(:something, :else)

    allow(mock_shell).to receive(:run).with(ssh_command_line).and_return(result)
    expect(result).to receive(:must_succeed!)

    command.enact
  end
end
