# Edict

Edict is a convenience library for describing a unit of work with parameters.
As such, it only really makes sense in context of other programs. The original
motivation was being able to build single, complex tasks in Mattock, but the
design is such that Edict tasks, having been defined in one place, can be made
available to other interfaces - Thor, for instance, or even wrapped in a little
shell script.

## Usage Examples

Starting simple:
```ruby
require 'edict'

class StartChild < Edict::Rule
  setting :manager
  setting :label
  setting :child_task

  def action
    manager.start_child(label, child_task)
  end
end
```

Then you'd use it like:
```ruby
starter = StartChild.new do |sc|
  sc.manager = manager
  sc.label = "Compass Watch"
  sc.child_task = "services:compass_watch"
  # or just copy_to(sc), depending on shared settings...
end
start.enact
```

Arguably, this is overkill. You could essentially replace any use of this class
with the contents of its action method (i.e. `manager.start_child(label,
child_task)` )

However, you get a number of nice benefits:

0. you get the Calibrate-provided niceties: being able to copy and compose
   configurations, and getting mis-use errors right away ("required field
   manager unset!") instead of late-fail exceptions ("NoMethodError on nil").
0. We also get the ability to centralize the behavior so that we can improve on
   it once and be sure that it's updated everywhere. (A fancy way of saying
   "DRY")
0. Finally, Edict::Rules are deadly simple to test - you can confirm that their
   action works correctly in one set of sets, and then mock the class later.

Edicts are very simple implementations of the
[Calibrate](https://git.lrdesign.com/lrd/calibrate) Configurable classes.

The full interface looks like:

```ruby
require 'edict'

class MyRule < Edict::Rule
  #Calibrate settings
  setting :whatever, "default value"
  setting :time
  required_field :something

  dir(:my_dir, "something", path(:my_file, "file"))

  def setup_defaults
    #use this for defaults that must be calculated
    self.time = Time.now
  end

  def setup
    #use this to calculate settings
    resolve_paths #required if using the dir/path stuff
  end

  def action
    # do whatever the class should do...
  end
```


## Commands

Edict includes two classes: `Edict::Command` and `Edict::SSHCommand` to cover
the common cases of running a configurable command. SSHCommand handles the
details of wrapping a remote command in a local SSH command. They're both
available if [Caliph](https://github.com/LRDesign/Caliph) is included in the
project.

Basically, just use the `setup` method to build an array of strings as the
`command` setting - the edict's action does all the Caliph steps to build and
run the command.

## Configuration

`edict` makes use of 'calibrate', and so has all the settings available there.
(ref to [Calibrate](https://git.lrdesign.com/lrd/calibrate) + explicit doc of
settings to follow.)

## Shell integration

edict can use caliph to build testable shell commands. Just add Caliph to your
project, and `Edict::Command` and `Edict::SSHCommand` become available.

## License

MIT style license granted. Text to be included.
