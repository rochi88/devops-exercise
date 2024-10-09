# Kill Processes in Linux \ Ubuntu

Every running program in the Linux Operating System (in every OS) has a unique PID, which stands for Process ID. This PID number is used to track the state and actions of the processes. The commands and tools kill a specific process by sending a signal to the OS along with the PID of the process to stop. 

However, caution must always be taken while trying to terminate or kill a process forcefully. Because if you accidentally exit a sensitive process (Kernel Processes), then you might end up damaging your Linux Installations.

## How to Kill a Specific Process in Linux\Ubuntu
Now that you are fully aware of what killing processes mean and how the killing process works, let’s move on to the steps for killing a specific process in Linux.

## Step 1: Find the PID of the Process to Kill

### 1. The top Command
The first command is the top command, which shows an overview of all the processes currently in your Linux Operating System. To this command, simply open up a new terminal and type “top,” and hit “Enter”

### 2. The ps Command
The next command that provides a little more readable output of the processes running in the Linux System is the “ps” command. Unlike the top command, the ps command also shows the system “All” processes, including kernel and system processes. To display the details of all processes, simply use the following command:
```sh
ps -ef
```
### 3. The pidof Command
One of the easiest commands to find the Process ID of a certain application is to use the “pidof” command. To use this command, simply follow the below-given syntax:
```sh
pidof {appname}
```
To find the PID of spotify, use the command:
```sh
pidof spotify
```

## Step 2: Kill the Process Using a Kill Command
Once you have found the PID of the process you want to kill, the next step is to simply use any of the available commands to kill a process. Let’s go through some most used Kill commands.

### 1. The Kill Command
The first and the most widely used command is the “Kill” command. The syntax of the kill command is given as follows:
```sh
kill {signal} {PID}
```
The kill commands tell the OS to terminate the Processes referred by the PID by using the Signal specific. Some common Signals are as follows:

* The -9 Signal: To forcefully terminal a Process (Kill Signal)
* The -15 Signal: To terminate the Process (Allows the program to run the exit code and stop its processing)
* The -1 Signal: To hang up the process
* The -17, -19, and -23 Signals: To stop the process (Stop Signal)
Let’s kill Spotify’s PID(from the previous section) using the -15 signal. To do that, type the following command:
```sh
kill -15 6847
```
Rerun the “pidof spotify” command to ensure that the process has stopped its processing. 

### 2. The killall Command
Instead of killing processes using the PID and having to either kill the parent PID or all child processes manually, you can use the Killall command. This command will kill all of the processes of a certain application. 

The syntax of the killall command is given as follows:
```sh
killall {appname}
```
To kill the processes of Firefox, use the following command:
```sh
killall firefox
```

### 3. The pKill Command
The pKill Command is similar to the killall command and terminates the processes associated with an application. To use this command, follow the following syntax:
```sh
pkill {appName}
```
For example, if you want to kill the Firefox browser using the pkill command, then type the following command:
```sh
pkill fire
```
