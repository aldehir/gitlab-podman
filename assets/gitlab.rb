# Docker options
## Prevent Postgres from trying to allocate 25% of total memory
postgresql['shared_buffers'] = '1MB'

# Disable Prometheus node_exporter inside Docker.
node_exporter['enable'] = false

# Manage accounts with docker
manage_accounts['enable'] = false

# Assign custom UID/GIDs
user['uid'] = user['gid'] = 898
web_server['uid'] = web_server['gid'] = 899
redis['uid'] = redis['gid'] = 897
postgresql['uid'] = postgresql['gid'] = 896

mattermost['uid'] = mattermost['gid'] = 894
registry['uid'] = registry['gid'] = 893
prometheus['uid'] = prometheus['gid'] = 892
consul['uid'] = consul['gid'] = 891

# Get hostname from shell
host = `hostname`.strip
external_url "http://#{host}"

# Explicitly disable init detection since we are running on a container
package['detect_init'] = false

# Load custom config from environment variable: GITLAB_OMNIBUS_CONFIG
# Disabling the cop since rubocop considers using eval to be security risk but
# we don't have an easy way out, atleast yet.
eval ENV["GITLAB_OMNIBUS_CONFIG"].to_s # rubocop:disable Security/Eval

# Load configuration stored in /etc/gitlab/gitlab.rb
from_file("/etc/gitlab/gitlab.rb")
