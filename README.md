# Edict

Edict is a convenience library for describing a unit of work with parameters.
As such, it only really makes sense in context of other programs. The original
motivation was being able to build single, complex tasks in Mattock, but the
design is such that Edict tasks, having been defined in one place, can be made
available to other interfaces - Thor, for instance, or even wrapped in a little
shell script.

## Configuration

`edict` makes use of 'calibrate', and so has all the settings available there.
(ref to Calibrate + explicit doc of settings to follow.)

## Shell integration

edict can use caliph to build testable shell commands. Just add Caliph to your
project, and `Edict::Command` and `Edict::SSHCommand` become available.

## License

MIT style license granted. Text to be included.
