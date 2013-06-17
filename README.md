# Deadline

Manage your task's deadlines  
![Screen Shot 1](https://raw.github.com/ikstrm/deadline/master/img/ss1.png)  

Keep your pace  
![Screen Shot 2](https://raw.github.com/ikstrm/deadline/master/img/ss2.png)  

Desktop notification  
![Screen Shot 3](https://raw.github.com/ikstrm/deadline/master/img/ss3.png)  

## Installation

Add this line to your application's Gemfile:

    gem 'deadline'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deadline

## Usage

    $ deadline add "task name1" 60   # the task's deadline will be 60min from now
    $ deadline add "task name2" 1:00 # the task's deadline will be 1:00
    $ deadline tasks                 # show task list
    $ deadline remove 0              # remove first task from task list
    $ deadline track                 # show timer and start desktop notification
    $ deadline remove all            # remove all tasks
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
