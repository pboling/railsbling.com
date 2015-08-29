+++
date = "2015-03-23T00:55:47-07:00"
draft = true
title = "first"
pygmentsuseclasses = true
+++

## First Post!

I am relaunching my blog!  I have decided to use [Hugo](https://gohugo.io/) for several reasons, after much internal debate, and blog 
reading, and because I desperately want to be cool.

```lang=html
<html>
    <body>
     <h1>This HTML</h1>
     <p>Paragraph!</p>
    </body>
</html>
```
Now Ruby:

```lang=ruby
class ClassProbe < Probe
  def local_method_defs(klass)
    klass.singleton_methods(false)
  end

  def get_method(klass, method_name)
    (class << klass; self; end).instance_method(method_name)
  end

  def define_trace_method(target, method)
    (class << target; self; end).class_exec() do
      define_method(method.name) do |*args, &block|
        ProbeRunner::probe_run(self, target.name, :class, args, caller(0)[0], method.name) do
          method.bind(self).call(*args, &block)
        end
      end
    end
  end
end
```

https://img.shields.io/github/forks/pboling/flag_shih_tzu.svg

How many Stars?
https://img.shields.io/github/stars/pboling/sanitize_email.svg



How are the dependencies?
https://img.shields.io/gemnasium/pboling/sanitize_email.svg

[![Throughput Graph](https://graphs.waffle.io/pboling/flag_shih_tzu/throughput.svg)](https://waffle.io/pboling/flag_shih_tzu/metrics)
