Create a new user in Linux

If you need to create a new user on a Linux server, the following two commands can do the job –
```
- useradd
- adduser
```
useradd – This command is available in all Linux distros. It accepts different arguments to create a new user in Linux. 
If run without arguments, the command will create a user account without a home directory, shell extension, etc.

Though, you can set the default options in /etc/default/useradd so that each time a user is created, the command takes the default values from /etc/default/useradd automatically.

adduser – A command written in perl that uses useradd in the backend. Unlike useradd, it only requires the username and runs a setup in the terminal to create a user.
It is easier than useradd.

adduser is only available in Ubuntu and other Debian based Linux distributions.


How to use useradd?
```
		useradd -m sandy
```
The above command will create a user account with a home directory at /home/sandy. Now set the password for the user.
```
		sudo passwd sandy
```
And that’s it. A user has been created. If you want to create a different home directory for the user, the -d parameter is for that.
```
		sudo useradd -d /home/james sandy
```
You can also set the shell in the useradd command. Just use the -s parameter.
```
		sudo useradd -d /home/james -s /bin/bash sandy
```

How to use adduser?

As I mentioned above, adduser is way easier than useradd. It only requires the username. 
adduser asks questions and sets the input values as the parameter values in useradd command.
```
		sudo adduser sandy
```
If you are using Ubuntu or other Debian based distros, go ahead with adduser command. This command was created to simplify the user creation process on Linux systems.

Add User group in Linux

Now we can create a group called ‘python-programmers’, add sandy, our python developer to this group and then grant him access to the Python directory.
```
		groupadd python-programmer
```

Add user to a group in Linux

Add sandy to the python-programmer group.
```
		sudo usermod -aG python-programmer sandy
```

Add group to a directory in Linux

Change the group of the Python directory that exists under $HOME/Projects/Python.
```
		sudo chown -R :python-programmer $HOME/Projects/Python
```

Add Permissions To Directory

Now add read & write permission to the directory for the group users.
```
		sudo chmod -R g+w $HOME/Projects/Python
```

Remove Permissions From Directory

And finally, disallow other users to access the Python directory.
```
		sudo chmod -R o-x Python
```
And the job is done! Now the Python directory can either be accessed by the root user or any user under the ‘python-programmers’ group.

But there is a problem!

The above procedure will do the job. It will grant access to users of python-programmers to the Python directory but there is a problem. 
The above approach will only allow one group of users to have access to the Python directory at a time. 
If you want to allow some other developers access to the Python directory, you will have to remove access from the previous group and set the new group as the owner of the directory.

To resolve this problem and allow access to multiple types of users at a time, we can use access control lists.


Access control lists

Let’s say we have a group of auditors in our company. We want to allow the users under the group auditors to have ‘read’ access to the Python directory without removing any other group from it.
```
		setfacl -m g:auditors:rx -R $HOME/Projects/Python
```
And that is it. Now the users of the python-programmers group have read & write access and users of auditors group have read access on the Python directory. If you want to allow auditors to also have write access, just add the w in the above command.
```
		setfacl -m g:auditors:rwx -R $HOME/Projects/Python
```

Remove user in Linux

You may also need to remove a user in Linux. It can be done using userdel command.
```
		userdel sandy
```
Warning

Deleting a user is a non-recoverable action. So make sure to backup important files and settings before removing any user. By default, the command will not remove the user’s home directory.
Notice

Before you remove any user in Linux, make sure no other process is being used by the user. Otherwise, you’ll get the following error –
```
		userdel: The user sandy is being used by process 3861
```

Kill all process being used by the user

killall command will kill all the users’ processes.
```
		killall -u sandy
```

Remove a Linux user

After all the users’ processes killed, the user can be deleted without any error.
```
		userdel sandy
```
As I mentioned above, by default the command will not remove the user’s home directory. To also remove the user’s home directory, add –-r argument to the command.
```
		userdel -r sandy
```

Remove user from a group in Linux

If you decide to snatch away rights from a user, simply remove the user from the group.
```
		sudo gpasswd -d sandy python-programmers
```
It the user is member of the group, it will output the following –
```
		Removing user sandy from group python-programmers
```

Remove a group in Linux

If you want to remove a group in Linux, just use groupdel command.
```
		groupdel username
```
If the deleting group is the primary group for any of the users on the system, the group can not be deleted. In that case, change the primary group of that user.

Delete auditors group from the system.
```
		groupdel auditors
```

