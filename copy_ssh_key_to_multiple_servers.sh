To copy an SSH public key to multiple servers, you can use a shell script that automates the process using ssh-copy-id. Below is a sample script that will allow you to copy your SSH public key to a list of servers.

Steps:
Ensure that you have SSH keys generated: If you haven’t done this yet, run the following command to generate the SSH key pair on your local machine:

bash
Copy code
ssh-keygen -t rsa -b 4096
This will create a public/private key pair (~/.ssh/id_rsa and ~/.ssh/id_rsa.pub by default).

Create the script: Create a script file (e.g., copy_ssh_key_to_multiple_servers.sh).

Edit the script to copy the public key to multiple servers.

Script: copy_ssh_key_to_multiple_servers.sh
bash
Copy code
-----------------------------------------------------------------------------------------------------------

#!/bin/bash

# List of servers to copy SSH key to
servers=(
    "server1.example.com"
    "server2.example.com"
    "server3.example.com"
    "dbserver1.example.com"
    "dbserver2.example.com"
    "webserver1.example.com"
    "webserver2.example.com"
#    "rockyprodsvr01.example.com"
#    "rockydevsvr01.example.com"
     # Add more servers as needed
    # Add more servers as needed
)

# Path to your public key (adjust if needed)
public_key="$HOME/.ssh/id_rsa.pub"

# Loop through each server and copy the public key
for server in "${servers[@]}"; do
    echo "Copying SSH key to $server..."
    ssh-copy-id -i "$public_key" "$server"
    
    if [ $? -eq 0 ]; then
        echo "SSH key copied successfully to $server"
    else
        echo "Failed to copy SSH key to $server"
    fi
done

echo "Finished copying keys to all servers."


---------------------------------------------------------------------------------------------------------------------------------------

How It Works:
servers array: This contains the list of server hostnames or IP addresses where you want to copy the SSH key.
ssh-copy-id: This is the utility that automatically copies your public key to the remote server’s ~/.ssh/authorized_keys file. 
It handles setting the correct permissions for the file and directory.
Loop: The script loops over all the servers in the servers array, attempting to copy the public key to each.
Make the Script Executable:
Save the script to a file, e.g., copy_ssh_key_to_multiple_servers.sh.

Make the script executable by running:

bash
Copy code
chmod +x copy_ssh_key_to_multiple_servers.sh
Run the Script:
Execute the script to copy your SSH key to all the servers listed in the servers array:

bash
Copy code
./copy_ssh_key_to_multiple_servers.sh
Notes:
SSH Access: You will need to have SSH access to the remote servers. You might be prompted for a password unless you already have key-based authentication set up.
Error Handling: The script checks whether ssh-copy-id was successful by inspecting the exit status ($?) and prints a success or failure message for each server.
Customization: You can modify the servers array to include as many servers as you want.
This script is an easy way to automate the process of distributing your SSH public key to multiple servers.

-----------------------------------------------------------------------------------------------------------------------
#!/bin/bash

# List of servers to copy SSH key to
servers=(
    "dbserver1.example.com"
    "dbserver2.example.com"               # this will target user 'root'
    "adele@dbserver1.example.com"         # this will target the user 'dele'
    "adele@dbserver2.example.com"
    "webserver1.example.com"
    "webserver2.example.com"
    "dele@webserver1.example.com"
    "dele@webserver2.example.com"
    "rockyprodsvr01.example.com"
    "rockydevsvr01.example.com"
    "adele@rockyprodsvr01.example.com"
    "adele@rockydevsvr01.example.com"
#   "server1.example.com"
#   "server2.example.com"
#   "server3.example.com"
# Add more servers as needed
)

# Path to your public key (adjust if needed)
public_key="$HOME/.ssh/id_rsa.pub"

# Loop through each server and copy the public key
for server in "${servers[@]}"; do                                                                             Bot Bot  Bot 
    echo "Copying SSH key to $server..."
     sudo ssh-copy-id -i "$public_key" "$server"     # Fresh Servers with no existing /.ssh/authorized_keys)
     sudo ssh-copy-id -f -i "$public_key" "$server"  # Servers with an existing /.ssh/authorized_keys, -f will override)

    if [ $? -eq 0 ]; then
       echo "SSH key copied successfully to $server"
    else
        echo "Failed to copy SSH key to $server"
    fi
done

echo "Finished copying keys to all servers."

OUTPUT OF THE SCRIPT RAN:

Number of key(s) added: 1

Now try logging into the machine, with:  "ssh 'webserver2.example.com'" and "ssh 'webserver2.example.com'"
and check to make sure that only the key(s) you wanted were added.


LAST UPDATES

#!/bin/bash

# List of servers to copy SSH key to
servers=(
    "dbserver1.example.com"
    "dbserver2.example.com"
    "adele@dbserver1.example.com"
    "adele@dbserver2.example.com"
    "webserver1.example.com"
    "webserver2.example.com"
    "dele@webserver1.example.com"
    "dele@webserver2.example.com"
    "rockyprodsvr01.example.com"
    "rockydevsvr01.example.com"
    "adele@rockyprodsvr01.example.com"
    "adele@rockydevsvr01.example.com"
#   "server1.example.com"
#   "server2.example.com"
#   "server3.example.com"
# Add more servers as needed
)

# Path to your public key (adjust if needed)
public_key="$HOME/.ssh/id_rsa.pub"

# Loop through each server and copy the public key
for server in "${servers[@]}"; do
    echo "Copying SSH key to $server..."
#   sudo ssh-copy-id -f -i "$public_key" "$server"  # To override an exisiting ~/.ssh
    sudo ssh-copy-id -i "$public_key" "$server"     # To copy ssh-key to fresh managed hosts/servers

    if [ $? -eq 0 ]; then
       echo "SSH key copied successfully to $server"
    else
        echo "Failed to copy SSH key to $server"
    fi
done

echo "Finished copying keys to all servers."