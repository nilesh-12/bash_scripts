#!/bin/bash

# Start the ssh-agent and if already have started. 
# Then add identities and if not already added.

sshkey=nilesh
# Check ssh-agent
if [[ ! -z ${SSH_AGENT_PID+x} ]]
then
    echo "[OK] ssh-agent is already running with pid: "${SSH_AGENT_PID}
else
    echo "Starting new ssh-agent..."
    `exec ssh-agent bash`
    echo "Started agent with pid: "${SSH_AGENT_PID}
fi
# Check ssh-key
if [[ $(ssh-add -L | grep ${sshkey} | wc -l) -gt 0 ]]
then
    echo "[OK] SSH key already added to ssh-agent"
else
    echo "Need to add SSH key to ssh-agent..."
    # This should prompt for your passphrase
    ssh-add ~/.ssh/${sshkey}
fi

# ref: https://stackoverflow.com/questions/40549332/how-to-check-if-ssh-agent-is-already-running-in-bash/48509425#48509425
